import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/router/app_router.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/constants/strings.dart';
import '../../../../core/utils/functions/custom_launch_url.dart';

class ReleasePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReleasePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Release Notes'),
      leading: CloseButton(
        onPressed: () async {
          final result = await context.maybePop();

          if (!result && context.mounted) {
            context.pushRoute(const HomeRoute());
          }
        },
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await customLaunchUrl('$kGitHubRepoUrl/releases', context);
          },
          icon: Icon(
            defaultTargetPlatform == TargetPlatform.windows ||
                    defaultTargetPlatform == TargetPlatform.macOS ||
                    defaultTargetPlatform == TargetPlatform.linux ||
                    defaultTargetPlatform == TargetPlatform.fuchsia
                ? Icons.install_desktop_rounded
                : Icons.install_mobile_rounded,
          ),
        ),
        const SizedBox(
          width: kDefaultPadding,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
