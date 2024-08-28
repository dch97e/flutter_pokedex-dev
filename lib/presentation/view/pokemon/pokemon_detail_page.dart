import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/presentation/common/base/resource_state.dart';
import 'package:flutter_pokedex/presentation/common/extensions/state_extensions.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/common/resources/app_colors.dart';
import 'package:flutter_pokedex/presentation/common/widget/detail_body.dart';
import 'package:flutter_pokedex/presentation/common/widget/error/error_overlay.dart';
import 'package:flutter_pokedex/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
import 'package:go_router/go_router.dart';
//import 'package:share_plus/share_plus.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({
    super.key,
  });

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage>
    with SingleTickerProviderStateMixin {
  final _pokemonViewModel = inject<PokemonViewModel>();
  final notifier = inject<PokemonProvider>();
  bool isFavorite = false;
  bool loading = true;
  late AnimationController _animationController;

  @override
  void initState() {
    notifier.addListener(() {
      if (mounted) {
        _pokemonViewModel.isFavoritePokemons(notifier.selectedPokemon!);
      }
    });
    notifier.isFavourite = false;

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();

    _pokemonViewModel.isFavoritePokemonState.stream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          //LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          // LoadingOverlay.hide();
          setState(() {
            isFavorite = event.data;
          });
          break;
        case Status.ERROR:
          // LoadingOverlay.hide();
          if (mounted) {
            ErrorOverlay.of(context).show(event.error, onRetry: () {});
          }
          break;
        default:
          // LoadingOverlay.hide();
          break;
      }
    });

    listenToProvider(notifier, () {
      _pokemonViewModel.isFavoritePokemons(notifier.selectedPokemon!);
    });

    _pokemonViewModel.isFavoritePokemons(notifier.selectedPokemon!);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: (() => context.pop()),
        ),
        title: Text(
          "${notifier.selectedPokemon!.name![0].toUpperCase()}${notifier.selectedPokemon!.name!.substring(1)}",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (isFavorite) {
                  _pokemonViewModel
                      .removeFavoritePokemons(notifier.selectedPokemon!);
                } else {
                  _pokemonViewModel
                      .addFavoritePokemons(notifier.selectedPokemon!);
                }
                isFavorite = !isFavorite;
                setState(() {});
              },
              icon: isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ))
        ],
      ),
      backgroundColor: AppColors.getColorType(
          notifier.selectedPokemon!.types.first.type!.name!),
      body: BodyWidget(
        animationController: _animationController,
      ),
    );
  }
}
