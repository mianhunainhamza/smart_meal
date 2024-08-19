import 'package:flutter/material.dart';
import '../../utils/font_sizes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class DetailScreen extends StatefulWidget {
  final String userName;
  final String photoUrl;
  final String email;
  const DetailScreen({
    super.key,
    required this.userName,
    required this.photoUrl,
    required this.email,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isMale = true;
  TextEditingController ageController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool isLoading = false;
  String country = '';

  addData() async {

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.padding.top + 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.photoUrl),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Tell us a bit more about yourself',
                    style: FontSizes.mainHeadingNormal,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _key,
                    child: Column(
                      children: [
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
                        const SizedBox(height: 20),
                        const Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 30),
                        CustomButton(
                          text: 'Submit',
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await addData();
                              setState(() {
                                isLoading = false;
                              });
                              // Get.offAll(const BottomNavbar());
                            }
                          },
                          isLoading: isLoading,
                          icon: null,
                          backgroundColor: Colors.black,
                          tag: 'Google tag',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
