// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      json['name'] as String,
      json['image'] as String,
      $enumDecode(_$StatusEnumMap, json['status']),
      json['species'] as String,
      Character._readName(json, 'origin') as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'status': _$StatusEnumMap[instance.status],
      'species': instance.species,
      'origin': instance.origin,
    };

const _$StatusEnumMap = {
  Status.alive: 'Alive',
  Status.dead: 'Dead',
  Status.unknown: 'unknown',
};
