import 'package:flutter/material.dart';

import '../../../../core/utils/constants/numbers.dart';

class DialogListTile extends StatelessWidget {
  final String title;
  final Icon? icon;
  final void Function()? onTap;

  const DialogListTile({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:  Text(title),
      leading: icon,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      onTap: onTap,
    );
  }
}
