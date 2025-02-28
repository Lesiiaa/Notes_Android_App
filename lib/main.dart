import 'package:Notes_App/services/authentication.dart';
import 'package:Notes_App/views/homepage/notes_page.dart';
import 'package:Notes_App/views/login/login_view.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();

  final isLoggedIn = await authService.isLoggedIn();
  runApp(MyApp(isLoggedIn: isLoggedIn));

}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const NotesPage() : const LoginView(),
    );
  }
}
