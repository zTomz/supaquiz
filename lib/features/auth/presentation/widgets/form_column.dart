import 'package:flutter/material.dart';

import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/functions/calculate_max_width.dart';

class FormColumn extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const FormColumn({
    super.key,
    required this.formKey,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Container(
          width: calculateMaxWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
