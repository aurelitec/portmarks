// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

/// A library for converting URLs to portmark files.
library;

/// The default portmark file contents template.
const String _portmarkFileContents = '''
<html>
<head>
  <meta http-equiv="refresh" content="0;url=INSERT-URL-HERE" />
</head>
<body>
</body>
</html>
''';

/// Converts a URL string to the string contents of a portmark file.
String urlToPortmarkString(String url) {
  return _portmarkFileContents.replaceAll('INSERT-URL-HERE', url);
}
