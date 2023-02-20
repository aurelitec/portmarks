import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'portmark_maker.dart';
import 'web_file_downloader.dart';
import 'filename_slugify.dart';

void convertUrlsToPortmarks(String urlsText) {
  List<String> urls = const LineSplitter().convert(urlsText);
  print(urls.length);

  if (urls.length > 1) {
    _convertAndDownloadMultipleUrls(urls);
  }

  // urls.forEach(_convertUrl);
}

void _addUrlToArchive(String url, Archive archive) {
  Uri? uri = Uri.tryParse(url);
  if (uri == null) return;

  String? portmarkString = urlToPortmarkString(url);
  if (portmarkString == null) return;

  final String fileName = uriToValidFileName(uri, '.html');
  ArchiveFile archiveFile = ArchiveFile.string(fileName, portmarkString);
  archive.addFile(archiveFile);
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
