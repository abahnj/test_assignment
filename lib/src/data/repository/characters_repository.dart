import 'package:casino_test/src/data/models/character.dart';

//ignore: one_member_abstracts
abstract class CharactersRepository {
  Future<List<Character>> getCharacters(int page);
}
