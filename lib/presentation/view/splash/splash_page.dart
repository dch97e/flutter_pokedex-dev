import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/presentation/common/base/resource_state.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/common/widget/error/error_overlay.dart';
import 'package:flutter_pokedex/presentation/navigation/navigation_routes.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _pokemonViewModel = inject<PokemonViewModel>();
  final notifier = inject<PokemonProvider>();
  int index = 0;
  @override
  void initState() {
    super.initState();
    _pokemonViewModel.fetchPokemons();

    _pokemonViewModel.pokemonListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          notifier.pokemonHome = state.data;
          if (notifier.pokemonHome.results != null) {
            notifier.addAllResultsToList(notifier.pokemonHome.results!);
          }

          _pokemonViewModel.getPokemonById(
              notifier.pokemonHomeList[index].url, index);
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

          if (index < notifier.pokemonHomeList.length && index < 19) {
            notifier.pokemonList.add(pokemon);
            _pokemonViewModel.getPokemonById(
                notifier.pokemonHomeList[index].url, index);
            index++;
          } else {
            notifier.pokemonList.add(pokemon);
            context.go(NavigationRoutes.pokemonRoute);
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
    return Scaffold(
      body: Container(), // Empty page
    );
  }
}
