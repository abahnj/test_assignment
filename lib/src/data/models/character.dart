import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

enum Status {
  @JsonValue('Alive')
  alive,
  @JsonValue('Dead')
  dead,
  @JsonValue('unknown')
  unknown
}

@JsonSerializable()
class Character extends Equatable {
  const Character(
    this.name,
    this.image,
    this.status,
    this.species,
    this.origin,
  );

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  final String name;
  final String image;
  final Status status;
  final String species;
  @JsonKey(readValue: _readName)
  final String origin;

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  static dynamic _readName(Map map, String key) =>
      map['origin']['name'].toString();

  @override
  List<Object?> get props => [name, image, species];
}
