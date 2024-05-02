import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../data/app_package_info.dart';
import '../widgets/release_page_app_bar.dart';

@RoutePage()
class ReleasePage extends StatelessWidget {
  const ReleasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReleasePageAppBar(),
      body: Markdown(
        data: AppPackageInfo().changelog,
      ),
    );
  }
}
