import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController =
      TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool obscureText = true;
  bool isMale = true;

  void createAndStoreUser() async {
    print('Created user');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        Row(
                          children:[ Text(
                            "Sign",
                            style: TextStyle(
                              fontSize: 40,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),Text(
                            " Up",
                            style: TextStyle(
                              fontSize: 40,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),]
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please enter correct info',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),

                        SizedBox(height: mediaQuery.size.height * 0.03),
                        CustomTextField(
                          controller: nameController,
                          labelText: 'User Name',
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(CupertinoIcons.person),
                        ),
                        SizedBox(height: mediaQuery.size.width * 0.01),
                        CustomTextField(
                          controller: emailController,
                          labelText: 'Email',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your valid email address';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        SizedBox(height: mediaQuery.size.width * 0.01),
                        // Gender Selection
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isMale = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: isMale ? Colors.blue : Colors.grey,
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: const Icon(
                                      Icons.male,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Male",
                                    style: TextStyle(
                                      color: isMale ? Colors.blue : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: mediaQuery.size.width * 0.15),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isMale = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: isMale ? Colors.grey : Colors.pink,
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: const Icon(
                                      Icons.female,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                      color: isMale ? Colors.grey : Colors.pink,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mediaQuery.size.width * 0.04),

                        // Age Input
                        CustomTextField(
                          controller: ageController,
                          labelText: 'Age',
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.cake),
                        ),
                        SizedBox(height: mediaQuery.size.width * 0.01),

                        // Password Input
                        CustomTextField(
                          controller: passController,
                          labelText: 'Password',
                          obscureText: obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password';
                            } else if (value.trim().length < 6) {
                              return 'Password must be 6 digits long';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(CupertinoIcons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: mediaQuery.size.width * 0.01),

                        // Confirm Password Input
                        CustomTextField(
                          controller: confirmPassController,
                          labelText: 'Confirm Password',
                          obscureText: obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please confirm your password';
                            } else if (value.trim() !=
                                passController.text.trim()) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(CupertinoIcons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: mediaQuery.size.width * 0.01),

                        CustomButton(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          text: "SIGN UP",
                          icon: Icons.arrow_forward,
                          isLoading: false,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              CustomSnackbar.showSnackBar(
                                  'Error',
                                  'Please fill all the fields',
                                  const Icon(Icons.warning_amber),
                                  Theme.of(context).colorScheme.onPrimary,
                                  context);
                              createAndStoreUser();
                              // Get.offAll(const BottomNavbar());
                            }
                          },
                          tag: 'onboard',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(.1)),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary.withOpacity(1),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
