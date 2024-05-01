import 'package:flutter/material.dart';
import 'package:flutter_pokedex/di/app_modules.dart';
import 'package:flutter_pokedex/presentation/common/provider/pokemon_provider.dart';

class StatsRow extends StatelessWidget {
  StatsRow({super.key});
  final notifier = inject<PokemonProvider>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(5, (index) => _statElement(index)),
    );
  }

  Widget _statElement(int index) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            notifier.selectedPokemon!.stats[index].stat.name.toUpperCase(),
            textAlign: TextAlign.center,
          ),
          Text('${notifier.selectedPokemon!.stats[index].baseStat}'),
        ],
      ),
    );
  }
}
