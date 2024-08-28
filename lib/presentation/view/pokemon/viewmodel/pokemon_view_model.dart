import 'dart:async';

import 'package:flutter_pokedex/domain/pokemon_repository.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/presentation/common/base/base_view_model.dart';
import 'package:flutter_pokedex/presentation/common/base/resource_state.dart';
import 'package:flutter_pokedex/presentation/common/errorhandling/app_action.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/viewmodel/pokemon_error_builder.dart';

class PokemonViewModel extends BaseViewModel {
  final PokemonRepository _pokemonRepository;
  final PokemonProvider _favoritePokemonProvider;

  PokemonViewModel(this._pokemonRepository, this._favoritePokemonProvider);

  StreamController<ResourceState> pokemonListState =
      StreamController<ResourceState>();
  StreamController<ResourceState> pokemonNextListState =
      StreamController<ResourceState>();
  StreamController<ResourceState> pokemonFavoriteListState =
      StreamController<ResourceState>();
  StreamController<ResourceState> addFavoritePokemonState =
      StreamController<ResourceState>();
  StreamController<ResourceState> removeFavoritePokemonState =
      StreamController<ResourceState>();
  StreamController<ResourceState> isFavoritePokemonState =
      StreamController<ResourceState>();
  StreamController<ResourceState> detailPokemonState =
      StreamController<ResourceState>();

  Future<void> fetchPokemons() async {
    pokemonListState.add(ResourceState.loading());

    _pokemonRepository
        .getPokemons()
        .then((value) => pokemonListState.add(ResourceState.completed(value)))
        .catchError((e) {
      pokemonListState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.GET_POKEMONS).build()));
    });
  }

  Future<void> getPokemonById(String url, int index) async {
    detailPokemonState.add(ResourceState.loading());

    _pokemonRepository
        .getPokemonById(url, index)
        .then((value) => detailPokemonState.add(ResourceState.completed(value)))
        .catchError((e) => detailPokemonState.add(ResourceState.error(
            PokemonErrorBuilder.create(e, AppAction.GET_POKEMON_BY_ID)
                .build())));
  }

  Future<void> fetchNextPokemons(String nextRequest) async {
    pokemonNextListState.add(ResourceState.loading());
    _pokemonRepository
        .getNextPokemons(nextRequest)
        .then(
            (value) => pokemonNextListState.add(ResourceState.completed(value)))
        .catchError((e) {
      pokemonNextListState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.GET_POKEMONS).build()));
    });
  }

  Future<void> fetchFavoritePokemons() async {
    pokemonFavoriteListState.add(ResourceState.loading());

    _pokemonRepository
        .getFavoritePokemons()
        .then((value) =>
            pokemonFavoriteListState.add(ResourceState.completed(value)))
        .catchError((e) {
      pokemonFavoriteListState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.GET_FAVORITE_POKEMON)
              .build()));
    });
  }

  Future<void> isFavoritePokemons(Pokemon pokemon) async {
    isFavoritePokemonState.add(ResourceState.loading());

    _pokemonRepository
        .isFavoritePokemon(pokemon)
        .then((value) =>
            isFavoritePokemonState.add(ResourceState.completed(value)))
        .catchError((e) {
      isFavoritePokemonState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.IS_FAVORITE_POKEMON)
              .build()));
    });
  }

  Future<void> addFavoritePokemons(Pokemon pokemon) async {
    pokemonFavoriteListState.add(ResourceState.loading());

    _pokemonRepository.addFavoritePokemon(pokemon).then((value) {
      pokemonFavoriteListState.add(ResourceState.completed(value));
      _favoritePokemonProvider.onFavoriteListUpdated();
    }).catchError((e) {
      addFavoritePokemonState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.ADD_FAVORITE_POKEMON)
              .build()));
    });
  }

  Future<void> removeFavoritePokemons(Pokemon pokemon) async {
    removeFavoritePokemonState.add(ResourceState.loading());

    _pokemonRepository.removeFavoritePokemon(pokemon).then((value) {
      removeFavoritePokemonState.add(ResourceState.completed(value));
      _favoritePokemonProvider.onFavoriteListUpdated();
    }).catchError((e) {
      removeFavoritePokemonState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.REMOVE_FAVORITE_POKEMON)
              .build()));
    });
  }

  @override
  void dispose() {
    pokemonListState.close();
    pokemonFavoriteListState.close();
    isFavoritePokemonState.close();
    addFavoritePokemonState.close();
    removeFavoritePokemonState.close();
    detailPokemonState.close();
  }
}
