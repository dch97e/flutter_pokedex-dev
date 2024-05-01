import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';

class PokemonTitleInfoWidget extends StatelessWidget {
  final notifier = inject<PokemonProvider>();

  PokemonTitleInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${notifier.selectedPokemon!.name[0].toUpperCase()}${notifier.selectedPokemon!.name.substring(1)}",
                style: textTheme.displayLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Text("#${notifier.selectedPokemon!.id}",
                  style: textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ))
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: notifier.selectedPokemon!.types
                    .map((type) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(38),
                                color: Colors.white.withOpacity(0.4)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(type.type.name,
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
