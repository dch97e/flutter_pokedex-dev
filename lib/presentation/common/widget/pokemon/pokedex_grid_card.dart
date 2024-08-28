import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:flutter_pokedex/presentation/common/canvas/white_pokeball_canvas.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/common/resources/app_colors.dart';
import 'package:flutter_pokedex/presentation/common/resources/app_styles.dart';
import 'package:go_router/go_router.dart';

class PokedexGridCard extends StatelessWidget {
  final Pokemon pokemon;
  final int index;
  final String route;
  final notifier = inject<PokemonProvider>();
  PokedexGridCard(
      {super.key,
      required this.pokemon,
      required this.route,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        notifier.selectedPokemon = pokemon;
        notifier.selectedFavouritePokemon = pokemon;
        context.go(route);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.getColorType(pokemon.types.first.type!.name!)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned(
                bottom: -15,
                right: -3,
                child: CustomPaint(
                  size: Size(
                      83,
                      (83 * 1.0040160642570282)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: PokeballLogoPainter(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              if (pokemon.sprites!.front_default != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7, bottom: 3),
                    child: SizedBox(
                      height: 76,
                      width: 76,
                      child: Image.network(
                        pokemon.sprites!.front_default!,
                      ),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: Text(
                    "#${pokemon.id}",
                    style: TextStyle(
                      fontFamily: "CircularStd-Book",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${pokemon.name![0].toUpperCase()}${pokemon.name!.substring(1)}",
                      style: AppStyles.smallTextStyle.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: pokemon.types
                          .map((type) => Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(38),
                                      color: Colors.white.withOpacity(0.4)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      type.type!.name!,
                                      style: AppStyles.bigTextStyle.copyWith(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
