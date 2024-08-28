import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/presentation/common/canvas/white_pokeball_canvas.dart';
import 'package:flutter_pokedex/presentation/common/localization/app_localizations.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/common/widget/pokemon/panel.dart';
import 'package:flutter_pokedex/presentation/common/widget/pokemon_data_detail.dart';

class PokemonImageDetail extends StatelessWidget {
  PokemonImageDetail({super.key, required this.animationController});
  final AnimationController animationController;
  final notifier = inject<PokemonProvider>();
  @override
  Widget build(BuildContext context) {
    final responsive = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Stack(
            children: [
              Center(
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: animationController.value * 2 * pi,
                      child: child,
                    );
                  },
                  child: CustomPaint(
                    size: Size(200, (200 * 1.0040160642570282).toDouble()),
                    painter: PokeballLogoPainter(
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.3)),
                  ),
                ),
              ),
              Center(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${notifier.selectedPokemon!.id}.png',
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    "#${notifier.selectedPokemon!.id}",
                    style: TextStyle(
                      fontFamily: "CircularStd-Book",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
              height: responsive.width / 2.3,
              child: Panel(
                  title: AppLocalizations.of(context)!.data_title,
                  child: PokemonDataDetail())),
        ),
      ],
    );
  }
}
