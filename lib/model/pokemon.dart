import 'package:json/json.dart';

@JsonCodable()
class Pokemon {
  Pokemon({
    required this.abilities,
    required this.base_experience,
    required this.cries,
    required this.forms,
    required this.game_indices,
    required this.height,
    required this.id,
    required this.location_area_encounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  final List<Ability> abilities;
  final int? base_experience;
  final Cries? cries;
  final List<Species> forms;
  final List<GameIndex> game_indices;
  final int? height;
  final int? id;
  final String? location_area_encounters;
  final List<Move> moves;
  final String? name;
  final int? order;
  final Species? species;
  final Sprites? sprites;
  final List<Stat> stats;
  final List<Type> types;
  final int? weight;
}

@JsonCodable()
class Ability {
  Ability({
    required this.ability,
    required this.is_hidden,
    required this.slot,
  });

  final Species? ability;
  final bool? is_hidden;
  final int? slot;
}

@JsonCodable()
class Species {
  Species({
    required this.name,
    required this.url,
  });

  final String? name;
  final String? url;
}

@JsonCodable()
class Cries {
  Cries({
    required this.latest,
    required this.legacy,
  });

  final String? latest;
  final String? legacy;
}

@JsonCodable()
class GameIndex {
  GameIndex({
    required this.game_index,
    required this.version,
  });

  final int? game_index;
  final Species? version;
}

@JsonCodable()
class Move {
  Move({
    required this.move,
    required this.version_group_details,
  });

  final Species? move;
  final List<VersionGroupDetail> version_group_details;
}

@JsonCodable()
class VersionGroupDetail {
  VersionGroupDetail({
    required this.level_learned_at,
    required this.move_learn_method,
    required this.version_group,
  });

  final int? level_learned_at;
  final Species? move_learn_method;
  final Species? version_group;
}

@JsonCodable()
class Other {
  Other({
    required this.dream_world,
    required this.home,
    required this.official_artwork,
    required this.showdown,
  });

  final DreamWorld? dream_world;
  final Home? home;
  final OfficialArtwork? official_artwork;
  final Sprites? showdown;
}

@JsonCodable()
class Sprites {
  Sprites({
    required this.back_default,
    required this.back_female,
    required this.back_shiny,
    required this.back_shiny_female,
    required this.front_default,
    required this.front_female,
    required this.front_shiny,
    required this.front_shiny_female,
    required this.other,
    required this.animated,
  });

  final String? back_default;
  final String? back_female;
  final String? back_shiny;
  final String? back_shiny_female;
  final String? front_default;
  final String? front_female;
  final String? front_shiny;
  final String? front_shiny_female;
  final Other? other;
  final Sprites? animated;
}

@JsonCodable()
class OfficialArtwork {
  OfficialArtwork({
    required this.frontDefault,
    required this.frontShiny,
  });

  final String? frontDefault;
  final String? frontShiny;
}

@JsonCodable()
class Home {
  Home({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;
}

@JsonCodable()
class Stat {
  Stat({
    required this.base_stat,
    required this.effort,
    required this.stat,
  });

  final int? base_stat;
  final int? effort;
  final Species? stat;
}

@JsonCodable()
class Type {
  Type({
    required this.slot,
    required this.type,
  });

  final int? slot;
  final Species? type;
}

@JsonCodable()
class DreamWorld {
  String? frontDefault;
  String? frontFemale;

  DreamWorld({
    this.frontDefault,
    this.frontFemale,
  });
}
