import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Launches the specified [URL] in the mobile platform, using the default external application.
///
/// Shows an error [SnackBar] if there is no support for launching the URL.
Future<void> launchUrlExternal(BuildContext context, String url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    // showSnackBar(context, '${strings.openFail} $url');
  }
}
