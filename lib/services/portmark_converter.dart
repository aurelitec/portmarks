import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:slugify/slugify.dart';

import 'portmark_maker.dart';
import 'web_file_downloader.dart';
// import 'filename_slugify.dart';

void convertUrlsToPortmarks(String urlsText) {
  List<String> urls = const LineSplitter().convert(urlsText);
  print(urls.length);

  if (urls.isEmpty) {
    return;
  }

  if (urls.length == 1) {
    _convertAndDownloadSingleUrl(urls[0]);
  } else if (urls.length > 1) {
    // _convertAndDownloadMultipleUrls(urls);
    for (var url in urls) {
      _convertAndDownloadSingleUrl(url);
    }
  }
}

/// The default file extension for a portmark file.
const String _portmarkFileExtension = '.html';

class _PortmarkFile {
  final String name;
  final String content;

  _PortmarkFile(this.name, this.content);
}

_PortmarkFile? _portmarkFileFromUrl(String urlString) {
  Uri? uri = Uri.tryParse(urlString);
  if (uri == null) {
    print('Invalid URL: $urlString');
    return null;
  } else {
    print('Good URL: $uri');
  }

  String? portmarkString = urlToPortmarkString(urlString);
  // print('portmarkString: $portmarkString');
  if (portmarkString == null) return null;

  // An inline function to sanitize a string by removing reserved characters for Windows paths
  String sanitize(String str) => str.replaceAll(RegExp(r'["*/:<>?\\|]'), '');

  // Compute the portmark base file name from the non-empty, sanitized host and path segments
  final String basename = [uri.host, ...uri.pathSegments]
      .map((seg) => sanitize(seg))
      .where((seg) => seg.isNotEmpty)
      .join('-');

  // Add the portmark file extension
  final String fileName = '$basename$_portmarkFileExtension';

  // Return the portmark file (name and contents)
  return _PortmarkFile(fileName, portmarkString);
}

void _addUrlToArchive(String url, Archive archive) {
  _PortmarkFile? portmarkFile = _portmarkFileFromUrl(url);
  if (portmarkFile == null) return;
  // Uri? uri = Uri.tryParse(url);
  // if (uri == null) {
  //   print('Invalid URL: $url');
  //   return;
  // }
  // print('Good URL: $url');

  // String? portmarkString = urlToPortmarkString(url);
  // if (portmarkString == null) return;
  // print('portmarkString: $portmarkString');

  // final String fileName = uriToValidFileName(uri, '.html');
  // ArchiveFile archiveFile = ArchiveFile.string(fileName, portmarkString);
  ArchiveFile archiveFile = ArchiveFile.string(portmarkFile.name, portmarkFile.content);
  archive.addFile(archiveFile);
}

void _convertAndDownloadSingleUrl(String url) {
  _PortmarkFile? portmarkFile = _portmarkFileFromUrl(url);
  if (portmarkFile == null) return;

  // Uri? uri = Uri.tryParse(url);
  // if (uri == null) return;

  // String? portmarkString = urlToPortmarkString(url);
  // if (portmarkString == null) return;

  // final String fileName = uriToValidFileName(uri, '.html');
  // final bytes = utf8.encode(portmarkFile.contents);
  webDownloadFile(portmarkFile.name, utf8.encode(portmarkFile.content));
}

void _convertAndDownloadMultipleUrls(List<String> urls) {
  Archive archive = Archive();
  for (var url in urls) {
    _addUrlToArchive(url, archive);
  }

  OutputStream outputStream = OutputStream(
    byteOrder: LITTLE_ENDIAN,
  );

  ZipEncoder zipEncoder = ZipEncoder();
  List<int>? bytes = zipEncoder.encode(
    archive,
    level: Deflate.BEST_COMPRESSION,
    output: outputStream,
  );

  if (bytes != null) {
    Uint8List uint8list = Uint8List.fromList(List<int>.from(bytes));
    webDownloadFile('portmarks.zip', uint8list);
  }
}
