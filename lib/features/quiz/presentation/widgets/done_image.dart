import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';

class DoneImage extends StatelessWidget {
  const DoneImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: min(MediaQuery.sizeOf(context).width * 0.8, 500),
        height: min(MediaQuery.sizeOf(context).width * 0.6, 375),
        child: ScalableImageWidget.fromSISource(
          fit: BoxFit.fitWidth,
          isComplex: true,
          si: ScalableImageSource.fromSI(
            rootBundle,
            'assets/vector_graphics/quiz_end.si',
          ),
        ),
      ),
    );
  }
}
