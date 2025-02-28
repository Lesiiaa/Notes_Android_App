import 'package:Notes_App/services/authentication.dart';
import 'package:Notes_App/utils/my_colors.dart';
import 'package:Notes_App/utils/my_images.dart';
import 'package:Notes_App/utils/my_text_styles.dart';
import 'package:Notes_App/views/homepage/notes_page.dart';
import 'package:Notes_App/views/register/register_view.dart';
import 'package:Notes_App/views/widgets/basic_text_form_field.dart';
import 'package:Notes_App/views/widgets/log_reg_btn.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // wywolanie metody logowania, authService
    final success = await authService.loginUser(email, password);

    if (success) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NotesPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,//roziaganie elementow na cala szerokosc
              children: [
                const SizedBox(height: 62),
                Center(
                  child: Image.asset(MyImages.logo),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 19, top: 21),
                  child: Text(
                    'Sign In',
                    style: MyTextStyles.mainTitle,
                  ),
                ),

                const SizedBox(height: 21),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BasicTextFormField(
                    controller: emailController,
                    hintText: 'Email or User Name',
                    prefixIcon: Image.asset(
                      MyImages.user_icon,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BasicTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Image.asset(
                      MyImages.lock_icon,
                    ),
                    obscureText: true, //ukrywanie tekstu
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 40),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: MyColors.purpleColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LogRegBtn(
                      buttonText: 'Sign In',
                      onPressed: _login,
                  ),
                ),

               //const Spacer(), //wypelnia wolna przestrzen

                Padding(
                  padding: const EdgeInsets.only(top: 240.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //wysrodkowuje rzad
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: MyColors.purpleColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: MyColors.purpleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // GestureDetector(
                //   child: const Text('Sign up?'),
                //   onTap: () {},
                // ),
              ],
            ),
          ),
        ),
    );
  }
}
