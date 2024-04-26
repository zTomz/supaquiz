import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/numbers.dart';
import 'create_new_quiz_dialog.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
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
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => const CreateNewQuizDialog(),
            );
          },
          child: const Icon(
            Icons.add_rounded,
            size: 30,
          ),
        ),
      ),
    );
  }
}
