import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/presentation/common/base/resource_state.dart';
import 'package:flutter_pokedex/presentation/common/extensions/state_extensions.dart';
import 'package:flutter_pokedex/presentation/common/localization/app_localizations.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/common/resources/app_colors.dart';
import 'package:flutter_pokedex/presentation/common/widget/error/error_overlay.dart';
import 'package:flutter_pokedex/presentation/common/widget/loading/loading_overlay.dart';
import 'package:flutter_pokedex/presentation/common/widget/pokemon/pokedex_grid_card.dart';
import 'package:flutter_pokedex/presentation/navigation/navigation_routes.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';

class FavPokemonListPage extends StatefulWidget {
  const FavPokemonListPage({super.key});

  @override
  State<FavPokemonListPage> createState() => _FavPokemonListPageState();
}

class _FavPokemonListPageState extends State<FavPokemonListPage>
    with AutomaticKeepAliveClientMixin {
  final _pokemonViewModel = inject<PokemonViewModel>();
  final notifier = inject<PokemonProvider>();
  List<Pokemon> filteredList = [];
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  Color? color;
  Map<String, dynamic> types = {};
  @override
  void initState() {
    super.initState();

    _pokemonViewModel.pokemonFavoriteListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          if (mounted) LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          LoadingOverlay.hide();
          setState(() {
            notifier.pokemonFavouriteList.clear();
            notifier.pokemonFavouriteList.addAll(state.data);
            filteredList.clear();
            filteredList.addAll(notifier.pokemonFavouriteList);
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          if (mounted) {
            ErrorOverlay.of(context).show(state.error, onRetry: () {
              _pokemonViewModel.fetchFavoritePokemons();
            });
          }
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    listenToProvider(notifier, () {
      _pokemonViewModel.fetchFavoritePokemons();
    });

    _pokemonViewModel.fetchFavoritePokemons();
  }

  Color? getColor() {
    int? bigger;
    String? biggerString;
    bool equal = false;
    types.clear();

    for (var element in notifier.pokemonFavouriteList) {
      if (types.containsKey(element.types.first.type!.name)) {
        int value1 = types[element.types.first.type!.name];
        types.update(element.types.first.type!.name!, ((value) => value1 + 1));
      } else {
        types.update(
          element.types.first.type!.name!,
          (value) => value++,
          ifAbsent: () => 1,
        );
      }
    }
    types.forEach((key, value) {
      if (biggerString == null && bigger == null) {
        biggerString = key;
        bigger = value;
      }
      if (biggerString != key) {
        if (bigger! < value) {
          biggerString = key;
          bigger = value;
          equal = false;
        } else if (bigger == value) {
          equal = true;
        } else {
          equal = false;
        }
      }
    });

    if (!equal) {
      if (biggerString != null) color = AppColors.getColorType(biggerString!);
    } else {
      color = null;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
        backgroundColor: getColor() ?? AppColors.bostonRed.withOpacity(0.5),
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
                    filteredList.addAll(notifier.pokemonFavouriteList.where(
                        (element) => element.name!
                            .toLowerCase()
                            .contains(value.toLowerCase())));
                    setState(() {});
                  },
                ),
              )
            : Text(
                AppLocalizations.of(context)!.pokemon_title_fav,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: filteredList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.40),
        itemBuilder: (context, index) {
          return PokedexGridCard(
              isFavourite: true,
              pokemon: filteredList[index],
              index: index + 1,
              route: NavigationRoutes.favoritePokemonDetailRoute);
        },
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
