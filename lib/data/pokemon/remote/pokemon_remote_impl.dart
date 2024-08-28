import 'package:flutter_pokedex/data/remote/error/remote_error_mapper.dart';
import 'package:flutter_pokedex/data/remote/http_client.dart';
import 'package:flutter_pokedex/data/remote/network_endpoints.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/model/pokemon_list.dart';

class PokemonRemoteImpl {
  final HttpClient _httpClient;
  PokemonRemoteImpl(this._httpClient);

  Future<Pokemonlist> getPokemons() async {
    try {
      dynamic response = await _httpClient.dio.get(
          NetworkEndpoints.pokemonListUrl,
          data: {"offset": 0, "limit": 20});

      Pokemonlist list = Pokemonlist.fromJson(response.data);

      return list;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<Pokemon> getPokemonById(String url) async {
    try {
      dynamic response = await _httpClient.dio.get(url);

      Pokemon pokemon = Pokemon.fromJson(response.data);

      return pokemon;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<Pokemonlist> getNextPokemons(String url) async {
    try {
      dynamic response = await _httpClient.dio.get(url);

      Pokemonlist list = Pokemonlist.fromJson(response.data);

      return list;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<Pokemon> getPokemonByUrl(String url) async {
    try {
      dynamic response = await _httpClient.dio.get(url);

      Pokemon pokemon = Pokemon.fromJson(response.data);

      return pokemon;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
