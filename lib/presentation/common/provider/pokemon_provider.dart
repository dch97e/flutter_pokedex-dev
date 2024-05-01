import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/model/pokemon_list.dart';

class PokemonProvider extends ChangeNotifier {
  Pokemonlist pokemonHome = Pokemonlist();
  final List<Result> pokemonHomeList = [];
  final List<Pokemon> pokemonList = [];
  final List<Pokemon> pokemonFavouriteList = [];

  Pokemon? selectedPokemon;
  Pokemon? selectedFavouritePokemon;
  void onFavoriteListUpdated() {
    notifyListeners();
  }

  addAllResultsToList(List<Result> newList) {
    pokemonHomeList.addAll(newList);
    notifyListeners();
  }
}
