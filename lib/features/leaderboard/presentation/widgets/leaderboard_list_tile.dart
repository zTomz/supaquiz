import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';

class LeaderboardListTile extends StatelessWidget {
  final UserModel user;

  const LeaderboardListTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      trailing: Text(
        "${user.points} points",
        style: const TextStyle(fontSize: 18),
      ),
      leading: CircleAvatar(
        radius: 26,
        child: Text(user.name.substring(0, 1)),
      ),
    );
  }
}
