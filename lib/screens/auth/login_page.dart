import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_meal/screens/auth/sign_up_page.dart';
import 'package:smart_meal/screens/inventory/inventory_screen.dart';
import 'package:smart_meal/screens/main_screen.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'forgot_pass_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _obscureText = true;
  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;
  late GlobalKey<FormState> _formKey;
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offsetAnimation = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.elasticOut));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 50,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(children: [
                    Text(
                      'Please sign in to continue',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 25),
                  SizedBox(
                    // width: mediaQuerySize.width * 0.88,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 90,
                            child: CustomTextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                              labelText: 'Email',
                              obscureText: false,
                              prefixIcon: const Icon(Icons.email),
                            ),
                          ),
                          SizedBox(height: mediaQuerySize.width * 0.05),
                          SizedBox(
                            height: 90,
                            child: CustomTextField(
                              controller: passController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              labelText: 'Password',
                              obscureText: _obscureText,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (c) => const ForgotPass()));
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.w300),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: mediaQuerySize.width * 0.1),
                  CustomButton(
                    text: 'L O G I N',
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          _isLoggingIn = true;
                        });
                        loginUser();
                        setState(() {
                          _isLoggingIn = false;
                        });
                      }
                    },
                    isLoading: _isLoggingIn,
                    icon: Icons.arrow_forward,
                    tag: 'onboard',
                  ),
                  SizedBox(height: mediaQuerySize.width * 0.14),
                  SizedBox(
                    width: mediaQuerySize.width - 100,
                    child: Row(children: [
                      const Flexible(
                        child: Divider(),
                      ),
                      Text(
                        "   OR   ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const Flexible(
                        child: Divider(),
                      ),
                    ]),
                  ),
                  SizedBox(height: mediaQuerySize.width * 0.1),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
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

  // Function to log in the user
  void loginUser() {
    Get.to(const MainScreen());
  }
}
