import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/utils/constants/numbers.dart';
import '../../../../core/config/utils/resources/supabase.dart';
import '../provider/user_provider.dart';

@RoutePage()
class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
        automaticallyImplyLeading: false,
      ),
      body: userProvider.users == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: kDefaultPadding),
                  Text(userProvider.failure?.errorMessage ?? "Loading..."),
                ],
              ),
            )
          : ListView.builder(
              itemCount: userProvider.users?.length,
              itemBuilder: (context, index) {
                final user = userProvider.users![index];

                return FutureBuilder<UserResponse>(
                  future: supabase.auth.admin.getUserById(user.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    print(snapshot.connectionState);
                    print(snapshot.error);

                    return const Text(
                      "Test",
                    );
                  },
                );
              },
            ),
    );
  }
}
