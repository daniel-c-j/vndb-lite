// coverage:ignore-file

// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:flutter/material.dart';

import '../../util/context_shortcut.dart';

// TODO delete those that are unnecessary

// Light theme
const Color PRIMARY_COLOR_L0 = Color.fromARGB(255, 90, 215, 10);
const Color PRIMARY_COLOR_L1 = Color.fromARGB(255, 110, 235, 30);
const Color PRIMARY_COLOR_L2 = Color.fromARGB(255, 135, 240, 70);
const Color SURFACE_COLOR_L0 = Color(0xFFFFFFFF); // White
const Color SURFACE_COLOR_L1 = Color(0xFF333333); // Dark grey
const Color SURFACE_DIM_COLOR_L = Color.fromARGB(255, 240, 240, 240); // Mercury
const Color TEXT_COLOR_L = Color(0xFF333333); // Dark grey

// Dark theme
const Color PRIMARY_COLOR_D0 = Color.fromARGB(255, 90, 195, 20);
const Color PRIMARY_COLOR_D1 = Color.fromARGB(255, 80, 165, 35);
const Color PRIMARY_COLOR_D2 = Color.fromARGB(255, 70, 125, 40);
const Color SURFACE_COLOR_D0 = Color(0xFF3f3f3f); // Mine Shaft
const Color SURFACE_COLOR_D1 = Color(0xFFFFFFFF); // White
const Color SURFACE_DIM_COLOR_D = Color(0xFF5b5b5b); // Scorpion
const Color TEXT_COLOR_D = Color(0xFFFFFFFF); // White

// Neutral
const Color SECONDARY_COLOR_V0 = Color(0xFFf20505); // Red
const Color SECONDARY_COLOR_V1 = Color(0xFFECC440); // Gold
const Color SECONDARY_COLOR_V2 = Color(0xFFFFFA8A); // Gold Light
const Color SECONDARY_COLOR_V3 = Color.fromARGB(255, 170, 20, 220); // Dark Purplish
const Color SECONDARY_COLOR_V4 = Color.fromARGB(255, 210, 10, 255); // Light Purplish

// Gradients
Gradient kGradientV0(BuildContext context) => LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [kColor(context).surface.withAlpha(200), PRIMARY_COLOR_L1.withAlpha(220), SECONDARY_COLOR_V0],
    );
