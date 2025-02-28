import 'package:Notes_App/services/authentication.dart';
import 'package:Notes_App/utils/my_colors.dart';
import 'package:Notes_App/utils/my_images.dart';
import 'package:Notes_App/utils/my_text_styles.dart';
import 'package:Notes_App/views/login/login_view.dart';
import 'package:Notes_App/views/widgets/basic_text_form_field.dart';
import 'package:Notes_App/views/widgets/log_reg_btn.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

  class _RegisterViewState extends State<RegisterView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService();

  void _register() async {
  final fullName = fullNameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text.trim();
  final confirmPassword = confirmPasswordController.text.trim();

  if (fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
  _showMessage('All fields are required!');
  return;
  }

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegex.hasMatch(email)) {
    _showMessage('Please enter a valid email address!');
    return;
  }

  if (password != confirmPassword) {
  _showMessage('Passwords do not match!');
  return;
  }

  final success = await authService.registerUser(fullName, email, password);

  if (success) {
  _showMessage('Registration successful!', isSuccess: true);
  Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const LoginView()),
  );
  } else {
  _showMessage('Registration failed. Email might already be taken.');
  }
  }

  void _showMessage(String message, {bool isSuccess = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  content: Text(message),
  backgroundColor: isSuccess ? Colors.green : Colors.red,
  ),
  );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
        child: Stack(//by dodac element dekoracyjny bez zmiany kod column
          children: [
            Positioned(
              top:0,
              // top: MediaQuery.of(context).padding.top
              right: 0,
              child: Image.asset(
                MyImages.shapes_reg,
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 59, left: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        //push
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset(MyImages.reg_back_btn),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: MyColors.purpleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50),
                  child: Text(
                    'Sign Up',
                    style: MyTextStyles.mainTitle,
                  ),
                ),

                const SizedBox(height: 46),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BasicTextFormField(
                    controller: fullNameController,
                    hintText: 'Full Name',
                    prefixIcon: Image.asset(
                      MyImages.user_icon,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BasicTextFormField(
                    controller: emailController,
                    hintText: 'Email',
                    prefixIcon: Image.asset(
                      MyImages.email_icon,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BasicTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Image.asset(
                      MyImages.lock_icon,
                    ),
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BasicTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    prefixIcon: Image.asset(
                      MyImages.lock_icon,
                    ),
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 80),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: LogRegBtn(
                      buttonText: 'Sign Up',
                      onPressed: _register,
                      ),
                ),

                //const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(top: 139),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //wysrodkowuje rzad
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: MyColors.purpleColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: MyColors.purpleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
