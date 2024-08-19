import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPass();
}

class _ForgotPass extends State<ForgotPass>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  late GlobalKey<FormState> _formKey;
  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Reset Password',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SlideTransition(
        position: offsetAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: mediaQuerySize.height * 0.5,
                child: Lottie.asset('assets/lottie/login.json'),
              ),
              SizedBox(
                width: mediaQuerySize.width * 0.83,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height: 100,
                          child: CustomTextField(
                            controller: emailController,
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'Email',
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Invalid email address';
                              }
                              return " ";
                            },
                          )),
                      SizedBox(height: mediaQuerySize.height * 0.08),
                      CustomButton(
                        text: 'Reset Password',
                        backgroundColor: CustomColors.blackprimaryDark,
                        onPressed: () {},
                        isLoading: false,
                        icon: Icons.arrow_forward,
                        tag: 'onboard',
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
