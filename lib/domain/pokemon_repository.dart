import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/model/pokemon_list.dart';

abstract class PokemonRepository {
  Future<Pokemonlist> getPokemons();
  Future<Pokemon> getPokemonById(String url, int id);
  Future<Pokemonlist> getNextPokemons(String nextRequest);
  Future<List<Pokemon>> getFavoritePokemons();
  Future<List<Pokemon>> addFavoritePokemon(Pokemon pokemon);
  Future<List<Pokemon>> removeFavoritePokemon(Pokemon pokemon);
  Future<bool> isFavoritePokemon(Pokemon pokemon);
}
