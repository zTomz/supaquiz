import 'package:flutter/material.dart';

import '../constants/numbers.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: kDefaultPadding),
          Text(message ?? "Loading..."),
        ],
      ),
    );
  }
}
