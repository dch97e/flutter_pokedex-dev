import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';

class SpritesRow extends StatelessWidget {
  SpritesRow({super.key});
  final notifier = inject<PokemonProvider>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          8,
          (index) => _spriteElement(index),
        ).toList(),
      ),
    );
  }

  Widget _spriteElement(int index) {
    String url = '';
    switch (index) {
      case 0:
        url = notifier.selectedPokemon!.sprites.frontDefault;
        break;
      case 1:
        url = notifier.selectedPokemon!.sprites.backDefault;
        break;
      case 2:
        url = notifier.selectedPokemon!.sprites.frontFemale ?? '';
        break;
      case 3:
        url = notifier.selectedPokemon!.sprites.backFemale ?? '';
        break;
      case 4:
        url = notifier.selectedPokemon!.sprites.frontShiny;
        break;
      case 5:
        url = notifier.selectedPokemon!.sprites.backShiny;
        break;
      case 6:
        url = notifier.selectedPokemon!.sprites.frontShinyFemale ?? '';
        break;
      case 7:
        url = notifier.selectedPokemon!.sprites.backShinyFemale ?? '';
        break;
    }

    if (url == '') {
      return Container();
    }

    return CachedNetworkImage(imageUrl: url);
  }
}
