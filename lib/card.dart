import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TypeCard extends StatelessWidget {
  final String type;

  TypeCard(this.type);
  @override
  Widget build(BuildContext context) {
    String typeIcon = setTypeIcon(type);
    String typeText = toBeginningOfSentenceCase(type);
    return Material(
      elevation: 2,
      shadowColor: setTypeColor(type),
      borderRadius: BorderRadius.circular(3),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: setTypeColor(type),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              typeIcon,
              style: TextStyle(
                fontFamily: 'PokeGoTypes',
                color: Colors.white,
              ),
            ),
            SizedBox(width: 5),
            Text(
              typeText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.5, 2),
                    blurRadius: 3.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PokeCard extends StatelessWidget {
  final dynamic poke;
  final String name;
  final BuildContext context;

  PokeCard(this.poke, this.context, this.name);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
        margin: EdgeInsets.only(bottom: 20, top: 5, left: 5, right: 5),
        decoration: BoxDecoration(
          color: setCardColor(poke.type1.toString()),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: setCardColor(poke.type1.toString()).withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                Text(
                  toBeginningOfSentenceCase(poke.name),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    if (poke.type1 != null) TypeCard(poke.type1),
                    SizedBox(width: 5),
                    if (poke.type2 != null) TypeCard(poke.type2),
                  ],
                )
              ],
            ),
            Positioned(
              right: -35,
              bottom: -50,
              child: FadeInImage.assetNetwork(
                placeholder: 'images/pokeLoad.gif',
                image: poke.sprite,
                imageScale: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String setTypeIcon(String type) {
  switch (type) {
    case 'fire':
      return 'G';
      break;
    case 'grass':
      return 'J';
      break;
    case 'water':
      return 'R';
      break;
    case 'rock':
      return 'P';
      break;
    case 'bug':
      return 'A';
      break;
    case 'normal':
      return 'M';
      break;
    case 'poison':
      return 'N';
      break;
    case 'electric':
      return 'D';
      break;
    case 'ground':
      return 'K';
      break;
    case 'ice':
      return 'L';
      break;
    case 'dark':
      return 'B';
      break;
    case 'fairy':
      return 'E';
      break;
    case 'psychic':
      return 'O';
      break;
    case 'fighting':
      return 'F';
      break;
    case 'ghost':
      return 'I';
      break;
    case 'flying':
      return 'H';
      break;
    case 'dragon':
      return 'C';
      break;
    case 'steel':
      return 'Q';
      break;
    default:
      return 'A';
  }
}

Color setCardColor(String type) {
  type = type.toLowerCase();
  if (type == null) {
    return Color(0xffdbd9d9);
  }
  switch (type) {
    case 'fire':
      return Color(0xfffa9950);
      break;
    case 'grass':
      return Color(0xff91eb5b);
      break;
    case 'water':
      return Color(0xFF69b9e3);
      break;
    case 'rock':
      return Color(0xffedd040);
      break;
    case 'bug':
      return Color(0xffbed41c);
      break;
    case 'normal':
      return Color(0xffC6C6A7);
      break;
    case 'poison':
      return Color(0xffd651d4);
      break;
    case 'electric':
      return Color(0xffF7D02C);
      break;
    case 'ground':
      return Color(0xfff5d37d);
      break;
    case 'ice':
      return Color(0xff79dbdb);
      break;
    case 'dark':
      return Color(0xffa37e65);
      break;
    case 'fairy':
      return Color(0xfffaa7d0);
      break;
    case 'psychic':
      return Color(0xffff80a6);
      break;
    case 'fighting':
      return Color(0xffe8413a);
      break;
    case 'ghost':
      return Color(0xff9063c9);
      break;
    case 'flying':
      return Color(0xffbda8f7);
      break;
    case 'dragon':
      return Color(0xff9065f7);
      break;
    case 'steel':
      return Color(0xffa0a0de);
      break;
    default:
      return Color(0xffdbd9d9);
  }
}

Color setTypeColor(String type) {
  type = type.toLowerCase();
  if (type == null) {
    return Color(0xffdbd9d9);
  }
  switch (type) {
    case 'fire':
      return Color(0xffF08030);
      break;
    case 'grass':
      return Color(0xff7AC74C);
      break;
    case 'water':
      return Color(0xFF6390F0);
      break;
    case 'rock':
      return Color(0xffB6A136);
      break;
    case 'bug':
      return Color(0xffA8B820);
      break;
    case 'normal':
      return Color(0xffA8A878);
      break;
    case 'poison':
      return Color(0xffA33EA1);
      break;
    case 'electric':
      return Color(0xfffce321);
      break;
    case 'ground':
      return Color(0xffE2BF65);
      break;
    case 'ice':
      return Color(0xff98D8D8);
      break;
    case 'dark':
      return Color(0xff705746);
      break;
    case 'fairy':
      return Color(0xffD685AD);
      break;
    case 'psychic':
      return Color(0xffF95587);
      break;
    case 'fighting':
      return Color(0xffC22E28);
      break;
    case 'ghost':
      return Color(0xff735797);
      break;
    case 'flying':
      return Color(0xffA98FF3);
      break;
    case 'dragon':
      return Color(0xff6F35FC);
      break;
    case 'steel':
      return Color(0xffB7B7CE);
      break;
    default:
      return Color(0xffdbd9d9);
  }
}
