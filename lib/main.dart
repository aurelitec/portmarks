// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'common/ui_strings.dart';
import 'screens/converter_screen.dart';

void main() {
  runApp(const PortmarksApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ConverterScreen();
      },
    ),
  ],
);

/// The main Portmarks app widget.
class PortmarksApp extends StatelessWidget {
  /// Constructs a [PortmarksApp].
  const PortmarksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: UIStrings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
