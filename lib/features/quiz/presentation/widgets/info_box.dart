import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';

class InfoBox extends StatelessWidget {
  final Widget child;

  const InfoBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kLargePadding,
        vertical: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(kDefaultOffset, kDefaultOffset),
          ),
        ],
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      child: child,
    );
  }
}
