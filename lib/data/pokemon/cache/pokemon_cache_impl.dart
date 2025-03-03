import 'dart:convert';

import 'package:flutter_pokedex/data/cache/database_tables.dart';
import 'package:flutter_pokedex/data/cache/error/cache_error_mapper.dart';
import 'package:flutter_pokedex/data/cache/memory_cache.dart';
import 'package:flutter_pokedex/data/cache/pokemon_database_helper.dart';
import 'package:flutter_pokedex/model/pokemon.dart';

class PokemonCacheImpl {
  final PokemonDatabaseHelper _pokemonDatabaseHelper;
  final MemoryCache _memoryCache;

  PokemonCacheImpl(this._pokemonDatabaseHelper, this._memoryCache);

  Pokemon? getCachedPokemon(int id) {
    return _memoryCache.pokemonList[id];
  }

  void addCachedPokemon(int id, Pokemon pokemon) {
    _memoryCache.pokemonList[id] = pokemon;
  }

  Future<List<Pokemon>> getFavoritePokemons() async {
    try {
      return (await _pokemonDatabaseHelper.getAll(DatabaseTables.pokemon)).map(
        (e) {
          Map<String, dynamic> map = e;
          Map<String, dynamic> pokemonData = json.decode(map['json']);
          Pokemon p = Pokemon.fromJson(pokemonData);
          return p;
        },
      ).toList();
    } catch (e) {
      throw CacheErrorMapper.getException(e);
    }
  }

  Future<void> addFavoritePokemon(Pokemon pokemon) async {
    try {
      Map<String, dynamic> map = {
        'id': pokemon.id,
        'name': pokemon.name,
        'json': json.encode(pokemon.toJson()),
      };

      await _pokemonDatabaseHelper.insert(DatabaseTables.pokemon, map);
    } catch (e) {
      throw CacheErrorMapper.getException(e);
    }
  }

  Future<void> removeFavoritePokemon(Pokemon pokemon) async {
    try {
      await _pokemonDatabaseHelper.delete(
          DatabaseTables.pokemon, MapEntry('id', pokemon.id));
    } catch (e) {
      throw CacheErrorMapper.getException(e);
    }
  }

  Future<bool> isFavoritePokemon(Pokemon pokemon) async {
    try {
      await _pokemonDatabaseHelper.get(
          DatabaseTables.pokemon, MapEntry('id', pokemon.id));
      // No exception, item exists!
      return true;
    } catch (e) {
      return false;
    }
  }
}
