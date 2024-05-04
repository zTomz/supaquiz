import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extensions/snack_bar_extension.dart';

Future<void> customLaunchUrl(String url, BuildContext context) async {
    if (!await launchUrl(Uri.parse(url)) && context.mounted) {
      context.showSnackBar(
        message: 'Could not launch $url',
      );
    }
  }