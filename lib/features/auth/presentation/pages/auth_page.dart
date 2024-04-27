import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../data/repositories/authentication_repository.dart';
import '../widgets/form_column.dart';
import '../widgets/text_field.dart';

@RoutePage()
class AuthPage extends StatefulHookWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final usernameController = useTextEditingController();

    final isSignIn = useState<bool>(true);

    return Scaffold(
      body: FormColumn(
        formKey: _formKey,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.55,
            height: 200,
            child: AutoSizeText(
              isSignIn.value ? "Sign In" : "Sign Up",
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10000,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AuthTextField(
            label: "Email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            isEmptyError: "Please enter an email",
          ),
          const SizedBox(height: kDefaultPadding),
          AuthTextField(
            label: "Password",
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            isEmptyError: "Please enter a password",
          ),
          if (!isSignIn.value) ...[
            const SizedBox(height: kDefaultPadding),
            AuthTextField(
              label: "Username",
              controller: usernameController,
              keyboardType: TextInputType.name,
              isEmptyError: "Please enter a username",
            ),
          ],
          const SizedBox(height: kHugePadding),
          CustomElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }

              if (isSignIn.value) {
                await AuthenticationRepositoryImpl().signIn(
                  email: emailController.text,
                  password: passwordController.text,
                  context: context,
                );
              } else {
                await AuthenticationRepositoryImpl().signUp(
                  email: emailController.text,
                  password: passwordController.text,
                  username: usernameController.text,
                  context: context,
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isSignIn.value ? "Sign In" : "Sign Up"),
              ],
            ),
          ),
          const SizedBox(height: kHugePadding),
          TextButton(
            onPressed: () {
              isSignIn.value = !isSignIn.value;
            },
            child: Text(isSignIn.value ? "Sign up instead" : "Sign in instead"),
          )
        ],
      ),
    );
  }
}
