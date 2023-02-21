// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../common/app_urls.dart';
import '../../common/strings.dart' as strings;
import '../../utils/utils.dart' as utils;

/// The items that appear in the app drawer.
enum AppDrawerItems {
  portmark,
  support,
  rateApp,
  help,
  viewSource,
}

/// The main Material Design drawer of the app, with the main app functions.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  /// Starts a specific functionality of the app when the user taps a drawer [item].
  void _onItemTap(BuildContext context, AppDrawerItems item) {
    switch (item) {
      // Stay on the Portmark screen, just close the drawer
      case AppDrawerItems.portmark:
        Navigator.pop(context);
        break;

      // Launch the external Support url
      case AppDrawerItems.support:
        Navigator.pop(context);
        utils.launchUrlExternal(context, AppUrls.support);
        break;

      // Launch the external Rate App url
      case AppDrawerItems.rateApp:
        Navigator.pop(context);
        // utils.launchUrlExternal(context, AppUrls.rate);
        break;

      // Launch the external Online Help url
      case AppDrawerItems.help:
        Navigator.pop(context);
        utils.launchUrlExternal(context, AppUrls.help);
        break;

      // Launch the external View Source url
      case AppDrawerItems.viewSource:
        Navigator.pop(context);
        utils.launchUrlExternal(context, AppUrls.viewSource);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const _AppDrawerHeader(),

          // Random Color drawer item
          _buildItem(
            context,
            icon: Icons.bookmark,
            title: strings.portmarkDrawerTitle,
            subtitle: strings.portmarkDrawerSubtitle,
            item: AppDrawerItems.portmark,
          ),

          const Divider(),

          // Online Help drawer item
          _buildItem(
            context,
            icon: Icons.help_center,
            title: strings.helpDrawer,
            item: AppDrawerItems.help,
          ),

          // Support drawer item
          _buildItem(
            context,
            icon: Icons.support,
            title: strings.supportDrawer,
            item: AppDrawerItems.support,
          ),

          // Rate App drawer item
          // _buildItem(
          //   context,
          //   icon: Icons.star_rate_outlined,
          //   title: UIStrings.rateAppDrawer,
          //   item: AppDrawerItems.rateApp,
          // ),

          const Divider(),

          // View Source drawer item
          _buildItem(
            context,
            icon: Icons.source,
            title: strings.viewSourceDrawer,
            subtitle: strings.viewSourceDrawerSubtitle,
            item: AppDrawerItems.viewSource,
          ),
        ],
      ),
    );
  }

  /// Creates an app drawer item, with an optional [icon], a [title], and an optional [subtitle].
  Widget _buildItem(
    BuildContext context, {
    IconData? icon,
    required String title,
    String? subtitle,
    required AppDrawerItems item,
  }) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: () => _onItemTap(context, item),
    );
  }
}

/// The app drawer header.
///
/// It is filled with a background color, and displays the app name.
class _AppDrawerHeader extends StatelessWidget {
  const _AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      // decoration: BoxDecoration(color: color),
      child: Center(
        child: Text(
          strings.appName,
          // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          //       color: ColorUtils.contrastOf(color),
          //     ),
        ),
      ),
    );
  }
}
