import 'dart:async';
import 'dart:convert';
import 'package:example_flutter/src/utils/constants.dart';
import 'package:http/http.dart';

/// Funcion que obtiene las imagenes de Pixabay
Future<Map> getPics(String searchTerm) async {
  final url = 'https://pixabay.com/api/?key=${Constants.API_KEY}&q=$searchTerm&lang=en&image_type=all&pretty=true';
  print(url);
  final response = await get(url);
  return json.decode(response.body);
}