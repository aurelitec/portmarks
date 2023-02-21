// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

/// The light and dark themes of the app, and various style utility functions.
library;

import 'package:flutter/material.dart';

/// The main color of the app: Hyperlink Blue, as defined by the color-names GitHub project.
const Color _hyperlinkBlue = Color(0xFF0000EE);

/// Defines the default visual properties for this app's material widgets.
///
/// Supports both the light and dark versions of the user interface.
ThemeData appTheme(Brightness brightness) {
  // A color that is white in the light theme and black in the dark theme
  // final Color lightWhiteDarkBlack = brightness == Brightness.light ? Colors.white : Colors.black;

  // A color that is black in the light theme and white in the dark theme
  // final Color lightBlackDarkWhite = brightness == Brightness.light ? Colors.black : Colors.white;

  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _hyperlinkBlue,
      brightness: brightness,
      primary: _hyperlinkBlue,
      onPrimary: Colors.white,
    ),
  ).copyWith(
    // Use Hyperlink Blue for the app bar's background color for both the light and dark themes
    appBarTheme: const AppBarTheme(
      backgroundColor: _hyperlinkBlue,
      foregroundColor: Colors.white,
    ),
  );
}
