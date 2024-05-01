import 'package:flutter_pokedex/data/cache/memory_cache.dart';
import 'package:flutter_pokedex/data/cache/pokemon_database_helper.dart';
import 'package:flutter_pokedex/data/pokemon/cache/pokemon_cache_impl.dart';
import 'package:flutter_pokedex/data/pokemon/pokemon_data_impl.dart';
import 'package:flutter_pokedex/data/pokemon/remote/pokemon_remote_impl.dart';
import 'package:flutter_pokedex/data/remote/http_client.dart';
import 'package:flutter_pokedex/domain/pokemon_repository.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupPokemonModule();
  }

  _setupMainModule() {
    inject.registerSingleton(HttpClient());
    inject.registerSingleton(MemoryCache());
    inject.registerSingleton(PokemonDatabaseHelper());
  }

  _setupPokemonModule() {
    inject.registerSingleton(PokemonProvider());
    inject.registerFactory(() => PokemonRemoteImpl(inject.get()));
    inject.registerFactory(() => PokemonCacheImpl(inject.get(), inject.get()));
    inject.registerFactory<PokemonRepository>(
        () => PokemonDataImpl(inject.get(), inject.get()));
    inject.registerFactory(() => PokemonViewModel(inject.get(), inject.get()));
  }
}
