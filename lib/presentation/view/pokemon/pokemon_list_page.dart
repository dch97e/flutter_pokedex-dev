import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/presentation/common/base/resource_state.dart';
import 'package:flutter_pokedex/presentation/common/localization/app_localizations.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/common/resources/app_colors.dart';
import 'package:flutter_pokedex/presentation/common/widget/error/error_overlay.dart';
import 'package:flutter_pokedex/presentation/common/widget/pokemon/pokedex_grid_card.dart';
import 'package:flutter_pokedex/presentation/navigation/navigation_routes.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage>
    with AutomaticKeepAliveClientMixin {
  final controller = ScrollController();
  final _pokemonViewModel = inject<PokemonViewModel>();
  final notifier = inject<PokemonProvider>();
  bool loadingNext = false;
  // bool initLoading = true;
  bool isSearching = false;
  int index = kIsWeb ? 0 : 20;
  List<Pokemon> filteredList = [];
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (notifier.pokemonList.isNotEmpty) {
      filteredList.addAll(notifier.pokemonList);
    }
    if (kIsWeb) {
      _pokemonViewModel.fetchPokemons();
    } else {
      _pokemonViewModel.getPokemonById(
          notifier.pokemonHomeList[notifier.pokemonList.length].url,
          notifier.pokemonList.length);
    }
    _pokemonViewModel.pokemonListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          notifier.pokemonHome = state.data;
          if (notifier.pokemonHome.results != null) {
            notifier.addAllResultsToList(notifier.pokemonHome.results!);
          }
          if (index < 151) {
            _pokemonViewModel.getPokemonById(
                notifier.pokemonHomeList[index].url, index);
          }
          index++;

          setState(() {});
          break;
        case Status.ERROR:
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _pokemonViewModel.fetchNextPokemons(notifier.pokemonHome.next!);
          });
          break;
        default:
          break;
      }
    });
    _pokemonViewModel.detailPokemonState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          Pokemon pokemon = state.data;

          if (index < notifier.pokemonHomeList.length && index <= 151) {
            notifier.pokemonList.add(pokemon);
            filteredList.add(pokemon);
            _pokemonViewModel.getPokemonById(
                notifier.pokemonHomeList[index].url, index);
            index++;
            setState(() {});
          } else {
            notifier.pokemonList.add(pokemon);
            filteredList.add(pokemon);

            loadingNext = false;
            setState(() {});
          }

          break;
        case Status.ERROR:
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _pokemonViewModel.fetchPokemons();
          });
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Obtener el ancho total disponible
    double screenWidth = MediaQuery.of(context).size.width;

    // Calcular el número de columnas
    int crossAxisCount =
        !kIsWeb ? (screenWidth / 140).floor() : (screenWidth / 200).floor();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            isSearching
                ? IconButton(
                    onPressed: () {
                      isSearching = false;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ))
                : IconButton(
                    onPressed: () {
                      isSearching = true;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
          ],
          backgroundColor: AppColors.bostonRed.withOpacity(0.5),
          title: isSearching
              ? SizedBox(
                  height: kToolbarHeight * 0.7,
                  child: TextField(
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    controller: _searchController,
                    onChanged: (value) {
                      filteredList.clear();
                      filteredList.addAll(notifier.pokemonList.where(
                          (element) => element.name
                              .toLowerCase()
                              .contains(value.toLowerCase())));
                      setState(() {});
                    },
                  ),
                )
              : Text(
                  AppLocalizations.of(context)!.pokemon_title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            GridView.builder(
              controller: controller,
              padding: const EdgeInsets.all(10),
              itemCount: filteredList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: kIsWeb ? crossAxisCount : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.40),
              itemBuilder: (context, index) {
                return PokedexGridCard(
                    pokemon: filteredList[index],
                    index: index + 1,
                    route: NavigationRoutes.pokemonDetailRoute);
              },
            ),
            // if (loadingNext)
            //   Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Lottie.asset("assets/images/pikachu.json", height: 100))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pokemonViewModel.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
