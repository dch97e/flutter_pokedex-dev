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
        url = notifier.isFavourite
            ? notifier.selectedFavouritePokemon!.sprites!.front_default ?? ""
            : notifier.selectedPokemon!.sprites!.front_default ?? "";
        break;
      case 1:
        url = notifier.isFavourite
            ? notifier.selectedFavouritePokemon!.sprites!.back_default ?? ""
            : notifier.selectedPokemon!.sprites!.back_default ?? "";
        break;
      case 2:
        url = notifier.isFavourite
            ? notifier.selectedFavouritePokemon!.sprites!.front_female ?? ""
            : notifier.selectedPokemon!.sprites!.front_female ?? '';
        break;
      case 3:
        url = notifier.isFavourite
            ? notifier.selectedFavouritePokemon!.sprites!.back_female ?? ""
            : notifier.selectedPokemon!.sprites!.back_female ?? '';
        break;
      case 4:
        url = notifier.isFavourite
            ? notifier.selectedFavouritePokemon!.sprites!.front_shiny ?? ""
            : notifier.selectedPokemon!.sprites!.front_shiny ?? "";
        break;
      case 5:
        url = notifier.isFavourite
            ? notifier.selectedFavouritePokemon!.sprites!.back_shiny ?? ""
            : notifier.selectedPokemon!.sprites!.back_shiny ?? "";
        break;
      case 6:
        url = notifier.isFavourite
            ? notifier.selectedFavouritePokemon!.sprites!.front_shiny_female ??
                ""
            : notifier.selectedPokemon!.sprites!.front_shiny_female ?? '';
        break;
      case 7:
        url = notifier.isFavourite
            ? notifier.selectedFavouritePokemon!.sprites!.back_shiny_female ??
                ""
            : notifier.selectedPokemon!.sprites!.back_shiny_female ?? '';
        break;
    }

    if (url == '') {
      return Container();
    }

    return CachedNetworkImage(imageUrl: url);
  }
}
