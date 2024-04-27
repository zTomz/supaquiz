import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/constants/strings.dart';
import '../../../../core/utils/extensions/snack_bar_extension.dart';

class SupaQuizAboutDialog extends StatelessWidget {
  const SupaQuizAboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutDialog(
      applicationName: "SupaQuiz",
      applicationVersion: 'v0.0.1',
      applicationIcon: ClipRRect(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        child: SizedBox.square(
          dimension: 60,
          child: Image.asset(
            kAppIconUrl,
          ),
        ),
      ),
      children: [
        Text(
          "Credits:",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: kDefaultPadding),
        ListTile(
          title: const Text("Image from studio4rt on Freepik"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
          onTap: () {
            Clipboard.setData(
              const ClipboardData(
                text:
                    "https://www.freepik.com/free-vector/man-sysadmine-computer-programmer-working-computer_21852411.htm#fromView=search&page=1&position=22&uuid=de553a8d-4eea-487a-a02c-6037c353fa37",
              ),
            );

            context.showSnackBar(
              message: "Copied link to clipboard",
              foreground: Colors.black,
              background: AppColors.primary,
            );
          },
        )
      ],
    );
  }
}
