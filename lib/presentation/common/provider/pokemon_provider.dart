import 'package:flutter/foundation.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/model/pokemon_list.dart';

class PokemonProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Pokemonlist pokemonHome = Pokemonlist();
  final List<Result> pokemonHomeList = [];
  final List<Pokemon> pokemonList = [];
  final List<Pokemon> pokemonFavouriteList = [];
  bool isFavourite = false;
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
