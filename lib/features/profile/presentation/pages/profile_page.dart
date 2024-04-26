import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/config/router/app_router.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/constants/strings.dart';
import '../../../../core/utils/extensions/snack_bar_extension.dart';
import '../../../../core/utils/resources/supabase.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../data/data_sources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository.dart';
import '../widgets/user_bubble.dart';

@RoutePage()
class ProfilePage extends HookWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    if (user == null) {
      context.router.push(const AuthRoute());
    }

    final usernameController = useTextEditingController(
      text: user?.userMetadata?['username'],
    );
    final widgetState = useState<int>(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => AboutDialog(
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
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRadius),
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
                ),
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: kDefaultPadding),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserBubble(
              username: usernameController.text.isEmpty
                  ? "U"
                  : usernameController.text.substring(0, 1),
            ),
            const SizedBox(height: kHugePadding),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: TextField(
                controller: usernameController,
                onChanged: (_) => widgetState.value = widgetState.value + 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
              ),
            ),
            CustomElevatedButton(
              onPressed: () async {
                await ProfileRepositoryImpl(
                  remoteDataSource: ProfileRemoteDataSourceImpl(),
                ).updateProfile(
                  username: usernameController.text,
                );

                widgetState.value = widgetState.value + 1;
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Update Profile", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: kHugePadding),
            CustomElevatedButton(
              onPressed: () async {
                await supabase.auth.signOut();
              },
              color: AppColors.red,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
