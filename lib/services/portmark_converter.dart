// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

/// A library for converting and downloading URLs as portmark files.
library;

import 'dart:convert';

import 'portmark_maker.dart';
import 'web_file_downloader.dart';

/// The default file extension for a portmark file.
const String _portmarkFileExtension = '.html';

/// The default delay between downloading multiple portmark files. This is to avoid overloading the
/// browser with too many simultaneous downloads.
const Duration _portmarkDelay = Duration(seconds: 1);

/// Converts a list of URL strings to portmark files and downloads them.
void portmarkUrls(List<String> urls) {
  if (urls.length == 1) {
    // Convert and download a single URL, without a delay
    _portmarkSingleUrl(urls[0]);
  } else if (urls.length > 1) {
    // Convert and download multiple URLs, with a delay between each
    _portmarkMultipleUrls(urls);
  }
}

/// Converts a single URL string to a portmark file and downloads it.
bool _portmarkSingleUrl(String urlString) {
  Uri? uri = Uri.tryParse(urlString);
  if (uri == null) return false;

  String? portmarkString = urlToPortmarkString(urlString);

  // An inline function to sanitize a string by removing reserved characters for Windows paths
  String sanitize(String str) => str.replaceAll(RegExp(r'["*/:<>?\\|]'), '');

  // Compute the portmark base file name from the non-empty, sanitized host and path segments
  final String basename = [uri.host, ...uri.pathSegments]
      .map((seg) => sanitize(seg))
      .where((seg) => seg.isNotEmpty)
      .join('-');

  // Add the portmark file extension
  final String fileName = '$basename$_portmarkFileExtension';

  // Download the portmark file
  webDownloadFile(fileName, utf8.encode(portmarkString));

  return true;
}

/// Converts multiple URL strings to portmark files and downloads them.
///
/// The [urls] are converted and downloaded one at a time, with a one-second delay between each.
/// This is to avoid overloading the browser with too many simultaneous downloads.
void _portmarkMultipleUrls(List<String> urls) async {
  for (String url in urls) {
    await Future.delayed(_portmarkDelay);
    _portmarkSingleUrl(url);
  }
}
