import 'package:flutter_pokedex/model/pokemon.dart';

class MemoryCache {
  // Singleton class
  static final MemoryCache _memoryCache = MemoryCache._internal();

  factory MemoryCache() {
    return _memoryCache;
  }

  MemoryCache._internal() {
    // Empty constructor
  }

  //CacheData
  Map<int, Pokemon> pokemonList = {};

  clearAll() {
    pokemonList = {};
  }
}
