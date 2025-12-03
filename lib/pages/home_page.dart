import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chatbot/pages/chatbot_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final String displayName = user?.email ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                // This will trigger the AuthWrapper to redirect to Login
                Navigator.of(context).pushReplacementNamed('/');
                // Note: Since we are using direct navigation in AuthWrapper,
                // we might need to just pop everything or rely on AuthWrapper re-building.
                // However, AuthWrapper is at the root.
                // A better approach for logout in this simple app is to just sign out
                // and let the user restart or handle it if we had a stream listener.
                // For now, let's just push replacement to the root/login.
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello $displayName',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ChatbotPage()),
                );
              },
              icon: const Icon(Icons.chat),
              label: const Text('Go to Chatbot'),
            ),
          ],
        ),
      ),
    );
  }
}
