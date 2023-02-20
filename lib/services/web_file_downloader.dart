import 'dart:html';
import 'dart:typed_data';

void webDownloadFile(String fileName, Uint8List bytes) {
  final Blob blob = Blob([bytes]);
  final url = Url.createObjectUrlFromBlob(blob);

  final anchor = document.createElement('a') as AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = fileName;
  document.body!.children.add(anchor);

// download
  anchor.click();

// cleanup
  document.body!.children.remove(anchor);
  Url.revokeObjectUrl(url);
}