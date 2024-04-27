import 'package:flutter/material.dart';

import '../../../../core/utils/constants/numbers.dart';

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
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}
