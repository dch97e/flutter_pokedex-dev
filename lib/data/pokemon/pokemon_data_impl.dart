import 'package:flutter_pokedex/data/pokemon/cache/pokemon_cache_impl.dart';
import 'package:flutter_pokedex/data/pokemon/remote/pokemon_remote_impl.dart';
import 'package:flutter_pokedex/domain/pokemon_repository.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/model/pokemon_list.dart';

class PokemonDataImpl implements PokemonRepository {
  final PokemonRemoteImpl _remoteImpl;
  final PokemonCacheImpl _cacheImpl;

  PokemonDataImpl(this._remoteImpl, this._cacheImpl);

  @override
  Future<Pokemonlist> getPokemons() async {
    Pokemonlist pokemonList = await _remoteImpl.getPokemons();

    return pokemonList;
  }

  @override
  Future<Pokemon> getPokemonById(String url, int id) async {
    final cachedPokemon = _cacheImpl.getCachedPokemon(id);

    if (cachedPokemon != null) {
      return cachedPokemon;
    } else {
      final pokemon = await _remoteImpl.getPokemonById(url);
      _cacheImpl.addCachedPokemon(id, pokemon);
      return pokemon;
    }
  }

  @override
  Future<Pokemonlist> getNextPokemons(String nextRequest) async {
    Pokemonlist pokemonList = await _remoteImpl.getNextPokemons(nextRequest);

    return pokemonList;
  }

  @override
  Future<List<Pokemon>> addFavoritePokemon(Pokemon pokemon) {
    _cacheImpl.addFavoritePokemon(pokemon);
    return _cacheImpl.getFavoritePokemons();
  }

  @override
  Future<List<Pokemon>> getFavoritePokemons() async {
    List<Pokemon> l = await _cacheImpl.getFavoritePokemons();
    return l;
  }

  @override
  Future<List<Pokemon>> removeFavoritePokemon(Pokemon pokemon) {
    _cacheImpl.removeFavoritePokemon(pokemon);
    return _cacheImpl.getFavoritePokemons();
  }

  @override
  Future<bool> isFavoritePokemon(Pokemon pokemon) {
    return _cacheImpl.isFavoritePokemon(pokemon);
  }
}
