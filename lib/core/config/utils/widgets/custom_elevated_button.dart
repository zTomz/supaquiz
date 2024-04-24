import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/numbers.dart';


class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final void Function() onTap;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.child,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(kDefaultOffset, kDefaultOffset),
          ),
        ],
        color: color,
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
