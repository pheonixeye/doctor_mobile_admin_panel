import 'package:flutter/material.dart';

AlignmentDirectional alignmentFromString(String value) {
  return switch (value) {
    'topStart' => AlignmentDirectional.topStart,
    'topCenter' => AlignmentDirectional.topCenter,
    'topEnd' => AlignmentDirectional.topEnd,
    'centerStart' => AlignmentDirectional.centerStart,
    'center' => AlignmentDirectional.center,
    'centerEnd' => AlignmentDirectional.centerEnd,
    'bottomStart' => AlignmentDirectional.bottomStart,
    'bottomCenter' => AlignmentDirectional.bottomCenter,
    'bottomEnd' => AlignmentDirectional.bottomEnd,
    _ => AlignmentDirectional.center,
  };
}

enum AlignFromString {
  topStart('top start', 'اعلي للبداية'),
  topCenter('top center', 'اعلي للمنتصف'),
  topEnd('top end', 'اعلي للنهاية'),
  centerStart('center start', 'وسط للبداية'),
  center('center', 'وسط للمنتصف'),
  centerEnd('center end', 'وسط للنهاية'),
  bottomStart('bottom start', 'اسفل للبداية'),
  bottomCenter('bottom center', 'اسفل للمنتصف'),
  bottomEnd('bottom end', 'اسفل للنهاية');

  final String ar;
  final String en;

  const AlignFromString(this.en, this.ar);
}
