import 'package:casino_test/constants.dart';
import 'package:casino_test/ext.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({Key? key, required this.character}) : super(key: key);

  final Character character;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Stack(
        children: <Widget>[
          Container(
            height: 150,
            margin: const EdgeInsets.only(left: 46),
            decoration: BoxDecoration(
              color: const Color(0xFF3B3F43),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.fromLTRB(105, 16, 16, 16),
              constraints: const BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    character.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      if (character.status == Status.alive)
                        alive
                      else if (character.status == Status.dead)
                        dead
                      else
                        unknown,
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          '${character.status.name.capitalize()} - ${character.species}',
                          overflow: TextOverflow.ellipsis,
                          style: wp14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Origin:', style: originText),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(character.name, style: originName),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: FractionalOffset.centerLeft,
            child: Hero(
              tag: character.image,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  character.image,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
