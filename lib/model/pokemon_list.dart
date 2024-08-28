import 'package:json/json.dart';

@JsonCodable()
class Pokemonlist {
  int? count;
  String? next;
  String? previous;
  List<Result>? results = [];

  Pokemonlist({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  void add(Pokemonlist list) {
    if (list.results != null) {
      for (var element in list.results!) {
        results!.add(element);
      }
    }
  }
}

@JsonCodable()
class Result {
  final String name;
  final String url;

  Result({
    required this.name,
    required this.url,
  });
}
