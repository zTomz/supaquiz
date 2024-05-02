import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/numbers.dart';

double calculateMaxWidth(BuildContext context) {
  return min(MediaQuery.of(context).size.width, kMaxScreenWidth);
}
