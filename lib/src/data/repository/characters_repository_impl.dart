import 'dart:async';
import 'dart:convert';

import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl(this._client);

  final Client _client;

  @override
  Future<List<Character>> getCharacters(int page) async {
    final charResult = await _client.get(
      Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'),
    );
    final jsonMap = await json.decode(charResult.body) as Map<String, dynamic>;

    if (charResult.statusCode == 200) {
      return List.of(
        (jsonMap['results'] as List<dynamic>).map(
          (dynamic value) => Character.fromJson(value as Map<String, dynamic>),
        ),
      );
    }
    throw Exception('error fetching characters');
  }
}
