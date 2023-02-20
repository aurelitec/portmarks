// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.icon,
    required this.label,
    this.onPressed,
    this.isDark = false,
  }) : super(key: key);

  /// The button icon to display.
  final Widget? icon;

  /// The button's label string.
  final Widget label;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      icon: icon,
      label: label,
      onPressed: onPressed,
    );
  }
}
