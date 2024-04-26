import 'package:flutter/material.dart';

import '../../../../core/utils/constants/numbers.dart';

class ResultBox extends StatelessWidget {
  final String value;
  final String title;
  final Color color;

  const ResultBox({
    super.key,
    required this.value,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kLargePadding),
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
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
          Text(title),
        ],
      ),
    );
  }
}
