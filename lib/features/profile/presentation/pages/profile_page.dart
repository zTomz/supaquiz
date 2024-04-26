import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/config/router/app_router.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
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
