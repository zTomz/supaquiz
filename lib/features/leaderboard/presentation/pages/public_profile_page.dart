import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/numbers.dart';
import '../../data/models/user_model.dart';
import '../widgets/profile_card.dart';

@RoutePage()
class PublicProfilePage extends StatelessWidget {
  final UserModel user;

  const PublicProfilePage({
    super.key,
    required this.user,
    @PathParam('username') required String username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kLargePadding),
        child: Column(
          children: [
            const SizedBox(height: kHugePadding),
            ProfileCard(user: user),
            const SizedBox(height: kLargePadding),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Quizzes of ${user.name}:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: kLargePadding),
            Text(
              "Coming soon...",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: user.quizzes.length,
            //     itemBuilder: (context, index) {
            //       final quiz = user.quizzes[index];

            //       return Text(quiz.);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
