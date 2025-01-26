import 'dart:convert';
import 'package:flutter/foundation.dart' show kDebugMode;

String _prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

void dprint(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

void dprintPretty(Object? object) {
  if (kDebugMode) {
    print(_prettyJson(object));
  }
}
