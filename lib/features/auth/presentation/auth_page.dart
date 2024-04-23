import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: SupaEmailAuth(
              // redirectTo: kIsWeb ? null : 'io.mydomain.myapp://callback',
              onSignInComplete: (response) {
                // do something, for example: navigate('home');
              },
              onSignUpComplete: (response) {
                // do something, for example: navigate("wait_for_email");
              },
              metadataFields: [
                MetaDataField(
                  prefixIcon: const Icon(Icons.person),
                  label: 'Username',
                  key: 'username',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter something';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
