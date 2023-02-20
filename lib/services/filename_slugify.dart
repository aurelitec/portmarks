String uriToValidFileName(Uri uri, String fileExtension) {
  String fileNameFromUri = uri.authority + uri.path + (uri.hasQuery ? '?' : '') + uri.query;
  print('uriToValidFileName: $fileNameFromUri');
  // String fileNameFromUri = Uri(
  //   host: uri.host,
  //   path: uri.path,
  //   query: uri.query,
  // ).toString();
  // print(fileNameFromUri);

  return _makeFilenameSafe(fileNameFromUri) + fileExtension;
}

// Based on https://github.com/2n-1/safe_filename/blob/master/lib/safe_filename.dart

final List<String> _reservedCharacters = [
  '?',
  ':',
  '"',
  '*',
  '|',
  '/',
  '\\',
  '<',
  '>',
  '+',
  '[',
  ']',
];

String _makeFilenameSafe(
  String filename, {
  String separator = '_',
}) {
  // print(filename);
  String returnString = filename;

  for (var c in _reservedCharacters) {
    returnString = returnString.replaceAll(c, separator);
  }
  returnString = returnString.replaceAll(' ', separator);
  return returnString.toLowerCase();
}
