import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';

class AbilitiesData extends StatelessWidget {
  AbilitiesData({super.key});
  final notifier = inject<PokemonProvider>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notifier.selectedPokemon!.abilities.length,
      itemBuilder: (context, index) {
        return Text(
          notifier.selectedPokemon!.abilities[index].ability.name.toUpperCase(),
          style: const TextStyle(color: Colors.black),
        );
      },
    );
  }
}
