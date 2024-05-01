import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/constants/strings.dart';
import '../../../../core/utils/extensions/snack_bar_extension.dart';
import '../widgets/dialog_list_tile.dart';

class SupaQuizAboutDialog extends StatelessWidget {
  const SupaQuizAboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutDialog(
      applicationName: kAppName,
      applicationVersion: kAppVersion,
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
          "Support:",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: kDefaultPadding),
        DialogListTile(
          title: "Leave a star on Github",
          icon: const Icon(Icons.star_rounded, color: AppColors.primary),
          onTap: () async {
            await _launchUrl(kGitHubRepoUrl, context);
          },
        ),
        DialogListTile(
          title: "Image from studio4rt on Freepik",
          icon: const Icon(Icons.image_rounded),
          onTap: () async {
            await _launchUrl(kFreepikImageUrl, context);
          },
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    if (!await launchUrl(Uri.parse(url)) && context.mounted) {
      context.showSnackBar(
        message: 'Could not launch $url',
      );
    }
  }
}
