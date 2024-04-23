import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/utils/constants/colors.dart';
import '../../../../core/config/utils/constants/numbers.dart';

class AnswerContainer extends StatelessWidget {
  final String answer;
  final String selectedAnswer;
  final void Function() setSelectedAnswer;

  const AnswerContainer({
    super.key,
    required this.answer,
    required this.selectedAnswer,
    required this.setSelectedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: setSelectedAnswer,
      child: Container(
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
          color: answer.startsWith('(A)')
              ? AppColors.blue
              : answer.startsWith('(B)')
                  ? AppColors.green
                  : answer.startsWith('(C)')
                      ? AppColors.primary
                      : AppColors.red,
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AutoSizeText(
                answer,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            IgnorePointer(
              child: Radio<String>(
                value: answer,
                groupValue: selectedAnswer,
                onChanged: (_) => setSelectedAnswer,
                fillColor: const MaterialStatePropertyAll(Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
