import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/functions/calculate_max_width.dart';
import '../provider/user_provider.dart';
import '../widgets/leaderboard_list_tile.dart';
import '../../../../core/widgets/loading_indicator.dart';

@RoutePage()
class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  void initState() {
    super.initState();

    context.read<UserProvider>().eitherFailureOrUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
        automaticallyImplyLeading: false,
      ),
      body: userProvider.users == null
          ? LoadingIndicator(message: userProvider.failure?.errorMessage)
          : Center(
              child: SizedBox(
                width: calculateMaxWidth(context),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await context.read<UserProvider>().eitherFailureOrUsers();
                  },
                  child: ListView.builder(
                    itemCount: userProvider.users!.length,
                    itemBuilder: (context, index) {
                      return LeaderboardListTile(
                        user: userProvider.users![index],
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
