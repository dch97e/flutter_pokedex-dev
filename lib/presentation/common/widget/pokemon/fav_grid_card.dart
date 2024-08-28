import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokemon.dart';
import 'package:go_router/go_router.dart';

class FavGridCard extends StatelessWidget {
  final Pokemon pokemon;
  final String route;

  const FavGridCard({super.key, required this.pokemon, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => context.go(route, extra: pokemon)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Image(
                image: CachedNetworkImageProvider(
              pokemon.sprites!.front_default!,
            )),
            Text(
              '${pokemon.game_indices[3].game_index} - ${pokemon.name}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
