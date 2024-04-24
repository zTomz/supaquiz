import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  final String username;

  const UserBubble({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 60,
        child: Text(
          username,
          style: const TextStyle(
            fontSize: 60,
          ),
        ),
      ),
    );
  }
}
