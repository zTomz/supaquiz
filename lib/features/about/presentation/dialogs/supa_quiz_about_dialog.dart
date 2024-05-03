import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/constants/strings.dart';
import '../../../../core/utils/functions/custom_launch_url.dart';
import '../../../profile/presentation/widgets/dialog_list_tile.dart';
import '../../data/app_package_info.dart';

class SupaQuizAboutDialog extends StatelessWidget {
  const SupaQuizAboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutDialog(
      applicationName: kAppName,
      applicationVersion: AppPackageInfo().packageInfo.version,
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
            await customLaunchUrl(kGitHubRepoUrl, context);
          },
        ),
        DialogListTile(
          title: "Image from studio4rt on Freepik",
          icon: const Icon(Icons.image_rounded),
          onTap: () async {
            await customLaunchUrl(kFreepikImageUrl, context);
          },
        ),
      ],
    );
  }

  
}
