import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';

class DoneImage extends StatelessWidget {
  const DoneImage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Atribute image author: https://www.freepik.com/free-vector/man-sysadmine-computer-programmer-working-computer_21852411.htm#fromView=search&page=1&position=22&uuid=de553a8d-4eea-487a-a02c-6037c353fa37
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
