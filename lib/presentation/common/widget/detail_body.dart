import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/common/localization/app_localizations.dart';
import 'package:flutter_pokedex/presentation/common/widget/abilities_data.dart';
import 'package:flutter_pokedex/presentation/common/widget/pokemon/panel.dart';
import 'package:flutter_pokedex/presentation/common/widget/pokemon_image_detail.dart';
import 'package:flutter_pokedex/presentation/common/widget/sprites_row.dart';
import 'package:flutter_pokedex/presentation/common/widget/stats_row.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key, required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final responsive = MediaQuery.of(context).size;
    return Container(
      height: responsive.height,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: PokemonImageDetail(
                      animationController: animationController)),
              const SizedBox(height: 15),
              Panel(
                  title: AppLocalizations.of(context)!.stats_title,
                  child: StatsRow()),
              const SizedBox(height: 15),
              Panel(
                  title: AppLocalizations.of(context)!.sprites_title,
                  child: SpritesRow()),
              const SizedBox(height: 15),
              Panel(
                  title: AppLocalizations.of(context)!.abilities_title,
                  child: AbilitiesData()),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
