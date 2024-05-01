import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/presentation/view/home/home_page.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/fav_pokemon_detail_page.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/favorite_pokemon_list_page.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/pokemon_detail_page.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/pokemon_list_page.dart';
import 'package:flutter_pokedex/presentation/view/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRoutes {
  // Route paths (for subroutes) - private access
  static const String _pokemonDetailPath = 'detail';
  static const String _favPokemonDetailPath = 'favdetail';

  // Route names
  static const String initialRoute = '/';

  static const String pokemonRoute = '/pokemon';
  static const String pokemonDetailRoute = '$pokemonRoute/$_pokemonDetailPath';

  static const String favoritePokemonRoute = '/favpokemon';
  static const String favoritePokemonDetailRoute =
      '$favoritePokemonRoute/$_favPokemonDetailPath';
}

// Nav keys
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _pokemonNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _favPokemonNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NavigationRoutes.initialRoute,
    routes: [
      // Routes
      GoRoute(
          path: NavigationRoutes.initialRoute,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SplashPage()),

      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => HomePage(navigationShell: shell),
        branches: [
          StatefulShellBranch(navigatorKey: _pokemonNavigatorKey, routes: [
            GoRoute(
                path: NavigationRoutes.pokemonRoute,
                parentNavigatorKey: _pokemonNavigatorKey,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: PokemonListPage()),
                routes: [
                  GoRoute(
                    path: NavigationRoutes._pokemonDetailPath,
                    builder: (context, state) {
                      return const PokemonDetailPage();
                    },
                    routes: const [],
                  ),
                ]),
          ]),
          StatefulShellBranch(navigatorKey: _favPokemonNavigatorKey, routes: [
            GoRoute(
                path: NavigationRoutes.favoritePokemonRoute,
                parentNavigatorKey: _favPokemonNavigatorKey,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: FavPokemonListPage()),
                routes: [
                  GoRoute(
                      path: NavigationRoutes._favPokemonDetailPath,
                      builder: (context, state) {
                        return const FavPokemonDetailPage();
                      },
                      routes: const []),
                ]),
          ]),
        ],
      ),
    ]);
