import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/presentation/common/localization/app_localizations.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';
import 'package:flutter_pokedex/presentation/common/resources/app_styles.dart';

class PokemonDataDetail extends StatelessWidget {
  PokemonDataDetail({super.key});
  final notifier = inject<PokemonProvider>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppLocalizations.of(context)!.height} ${notifier.selectedPokemon!.height}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          Text(
            '${AppLocalizations.of(context)!.weight} ${notifier.selectedPokemon!.weight}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          Text(
            '${AppLocalizations.of(context)!.main_type} ${notifier.selectedPokemon!.types.first.type.name}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          notifier.selectedPokemon!.types.length == 2
              ? Text(
                  '${AppLocalizations.of(context)!.sec_type} ${notifier.selectedPokemon!.types[1].type.name}',
                  style: AppStyles.appTheme.textTheme.bodyMedium,
                )
              : Container(),
        ],
      ),
    );
  }
}
