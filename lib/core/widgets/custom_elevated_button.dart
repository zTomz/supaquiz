import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/numbers.dart';


class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final void Function() onPressed;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
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
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
