import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/common/localization/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.navigationShell,
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return NavigationBar(
      height: 60,
      selectedIndex: widget.navigationShell.currentIndex,
      onDestinationSelected: (index) {
        widget.navigationShell.goBranch(
          index,
          initialLocation: index == widget.navigationShell.currentIndex,
        );
      },
      destinations: [
        NavigationDestination(
          icon: SvgPicture.asset(
            "assets/images/pokedex.svg",
            height: 25,
          ),
          label: AppLocalizations.of(context)!.pokemon_title,
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            "assets/images/pokeball.svg",
            height: 25,
          ),
          label: AppLocalizations.of(context)!.pokemon_title_fav,
        ),
      ],
    );
  }
}
