// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

enum ThemeCode {
  agl(
    themeName: "Angel Serenade",
    backgroundImgPath: "assets/images/bg/bgAngel.png",
    seedColor: Color.fromARGB(255, 50, 80, 100),
    primary: Color.fromARGB(255, 50, 80, 100),
    secondary: Color.fromARGB(255, 140, 220, 255),
    tertiary: Colors.white,
    brightness: Brightness.light,
  ),

  air(
    themeName: "AIR",
    backgroundImgPath: "assets/images/bg/bgAIR.png",
    seedColor: Color.fromARGB(255, 180, 220, 255),
    primary: Color.fromARGB(255, 180, 220, 255),
    secondary: Color.fromARGB(255, 80, 130, 225),
    tertiary: Colors.black,
    brightness: Brightness.dark,
  ),

  ev17(
    themeName: "Ever17",
    backgroundImgPath: "assets/images/bg/bgEver17.png",
    seedColor: Color.fromARGB(255, 100, 180, 190),
    primary: Color.fromARGB(255, 100, 180, 190),
    secondary: Color.fromARGB(255, 240, 170, 100),
    tertiary: Colors.black,
    brightness: Brightness.dark,
  ),

  fate(
    themeName: "Fate/Stay Night",
    backgroundImgPath: "assets/images/bg/bgFate.png",
    seedColor: Color.fromARGB(255, 70, 50, 50),
    primary: Color.fromARGB(255, 70, 50, 50),
    secondary: Color.fromARGB(255, 210, 100, 70),
    tertiary: Colors.white,
    brightness: Brightness.light,
  ),

  carnvl(
    themeName: "Gekkou No Carnevale",
    backgroundImgPath: "assets/images/bg/bgCarnevale.png",
    seedColor: Color.fromARGB(255, 20, 20, 20),
    primary: Color.fromARGB(255, 20, 20, 20),
    secondary: Color.fromARGB(255, 190, 190, 190),
    tertiary: Colors.white,
    brightness: Brightness.light,
  ),

  hgrshi(
    themeName: "Higurashi No Naku Koro Ni",
    backgroundImgPath: "assets/images/bg/bgHigurashi.png",
    seedColor: Color.fromARGB(255, 250, 180, 160),
    primary: Color.fromARGB(255, 250, 180, 160),
    secondary: Color.fromARGB(255, 220, 220, 220),
    tertiary: Colors.black,
    brightness: Brightness.dark,
  ),

  tsukhme(
    themeName: "Tsukihime",
    backgroundImgPath: "assets/images/bg/bgTsukihime.png",
    seedColor: Color.fromARGB(255, 100, 80, 80),
    primary: Color.fromARGB(255, 100, 80, 80),
    secondary: Color.fromARGB(255, 250, 70, 70),
    tertiary: Colors.white,
    brightness: Brightness.light,
  ),

  toho(
    themeName: "Touhou",
    backgroundImgPath: "assets/images/bg/bgTouhou.png",
    seedColor: Color.fromARGB(255, 175, 175, 175),
    primary: Color.fromARGB(255, 175, 175, 175),
    secondary: Color.fromARGB(255, 215, 215, 215),
    tertiary: Colors.black,
    brightness: Brightness.dark,
  ),

  seinrkn(
    themeName: "Seinarukana",
    backgroundImgPath: "assets/images/bg/bgSeinaru.png",
    seedColor: Color.fromARGB(255, 255, 240, 240),
    primary: Color.fromARGB(255, 255, 240, 240),
    secondary: Color.fromARGB(255, 255, 70, 150),
    tertiary: Colors.black,
    brightness: Brightness.dark,
  ),

  lilbusts(
    themeName: "Little Busters!",
    backgroundImgPath: "assets/images/bg/bgLittleBusters.png",
    seedColor: Color.fromARGB(255, 250, 200, 250),
    primary: Color.fromARGB(255, 250, 200, 250),
    secondary: Color.fromARGB(255, 240, 80, 215),
    tertiary: Colors.black,
    brightness: Brightness.dark,
  ),

  saya(
    themeName: "Saya No Uta",
    backgroundImgPath: "assets/images/bg/bgSaya.png",
    seedColor: Color.fromARGB(255, 50, 100, 80),
    primary: Color.fromARGB(255, 50, 100, 80),
    secondary: Color.fromARGB(255, 240, 180, 140),
    tertiary: Colors.white,
    brightness: Brightness.light,
  );

  const ThemeCode({
    required this.themeName,
    required this.backgroundImgPath,
    required this.seedColor,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.brightness,
  });

  final String themeName;
  final String backgroundImgPath;
  final Color seedColor;
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Brightness brightness;
}
