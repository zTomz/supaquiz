import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/widgets/user_bubble.dart';
import '../../data/models/user_model.dart';

class ProfileCard extends StatelessWidget {
  final UserModel user;

  const ProfileCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kLargePadding),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      child: Wrap(
        spacing: 25,
        runSpacing: 25,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          UserBubble(username: user.name),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Username: ${user.name}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Joined at: ${user.createdAt.year}-${user.createdAt.month}-${user.createdAt.day}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Points: ${user.points}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
