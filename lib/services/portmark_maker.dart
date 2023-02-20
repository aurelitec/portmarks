
const String _portmarkFileContents = '''
<html>
<head>
  <meta http-equiv="refresh" content="0;url=INSERT-URL-HERE" />
</head>
<body>
</body>
</html>
''';

String? urlToPortmarkString(String url) {
  return _portmarkFileContents.replaceAll('INSERT-URL-HERE', url);
}