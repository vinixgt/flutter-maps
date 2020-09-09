import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

Future<Uint8List> loadAsset(String path, {
  int height = 50, 
  int width = 50,
}) async {
  ByteData data = await rootBundle.load(path);
  final Uint8List bytes = data.buffer.asUint8List();
  final ui.Codec codec = await ui.instantiateImageCodec(
    bytes,
    targetHeight: height,
    targetWidth: width,
  );
  final ui.FrameInfo frame = await codec.getNextFrame();
  data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
  return data.buffer.asUint8List();
}

Future<Uint8List> loadImageUrl(String url, {
  int height = 50, 
  int width = 50,
}) async {

  final http.Response response = await http.get(url);

  if(response.statusCode == 200) {
    final Uint8List bytes = response.bodyBytes;
    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetHeight: height,
      targetWidth: width,
    );
    final ui.FrameInfo frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }
  throw new Exception('Download failed');
}