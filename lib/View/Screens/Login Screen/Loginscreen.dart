// iimport 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lilacmachinetest/Helper/SharedprefrenceHelper.dart';
import 'package:lilacmachinetest/View/Screens/Home%20Screen/homescreen.dart';
import 'package:lilacmachinetest/View/Screens/Tabmanager%20Screen/tabmanagerscreen.dart';
import 'package:lilacmachinetest/provider/Apiservice.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> loginUser(String username, String password) async {
    print("UserName - $username");
    print("Password - $password");

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/api/lead/auth/login'),
        body: {
          'userField': username,
          'password': password,
        },
      );

      print("Status Code - ${response.statusCode}");

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        final bool loginStatus = data['status'];

        print("Status - $loginStatus");

        if (loginStatus) {
          final String token = data['data']['auth']['access_token'];
          await Sharedpreferencehelper().setAuthToken(token);

          Get.snackbar(
            "",
            "",
            titleText: const Text(
              "Login Success",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
            ),
            messageText: const Text(
              "Successfully logged in",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
            shouldIconPulse: true,
            icon: SvgPicture.asset(
              "assets/svgs/success.svg",
              height: 25,
              width: 25,
            ),
          );

          Get.to(
            () => const Tabmanagerscreen(),
            duration: const Duration(seconds: 1),
            transition: Transition.fadeIn,
          );
        } else {
          Get.snackbar(
            "",
            "",
            titleText: const Text(
              "Login failed. Please verify your credentials",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            messageText: const Text(
              "Only registered users can log in. Please contact the admin.",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
            shouldIconPulse: true,
            icon: SvgPicture.asset(
              "assets/svgs/failed.svg",
              height: 25,
              width: 25,
            ),
          );
        }
      } else {
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Connection Error",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          messageText: const Text(
            "Failed to connect to the server. Please try again later.",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          shouldIconPulse: true,
          icon: SvgPicture.asset(
            "assets/svgs/failed.svg",
            height: 25,
            width: 25,
          ),
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "",
        "",
        titleText: const Text(
          "Error",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
        messageText: const Text(
          "An unexpected error occurred. Please try again.",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        shouldIconPulse: true,
        icon: SvgPicture.asset(
          "assets/svgs/failed.svg",
          height: 25,
          width: 25,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 30),
                child: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start with',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF777AAE),
                          ),
                        ),
                        Text(
                          'Lilac Infotech',
                          style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'Inter',
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Enter your mobile number',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'InterMedium',
                            color: Color(0xFF777AAE),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: Image.asset('assets/images/login.png'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 20),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email/ Phone Number',
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xFFBDBEDC)),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFBDBEDC)), // Border color
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFBDBEDC)), // Border color
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFBDBEDC)), // Border color
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 20, top: 20),
                child: TextField(
                  controller: passwordController,
                  // obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xFFBDBEDC)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color(0xFFBDBEDC)), // Border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color(0xFFBDBEDC)), // Border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color(0xFFBDBEDC)), // Border color
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                            activeColor: const Color(0xFFBDBEDC),
                            side: const BorderSide(color: Color(0xFFBDBEDC)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                            value: false,
                            onChanged: (bool? value) {}),
                        const Text(
                          'Remember Me',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Color.fromARGB(255, 138, 138, 153),
                            fontSize: 14,
                            fontFamily: 'InterMedium',
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?',
                          style: TextStyle(
                              color: Color(0xFFFF1B6F),
                              fontSize: 14,
                              fontFamily: 'InterMedium')),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 20,
                  bottom: 20,
                  top: 20,
                ),
                child: SizedBox(
                  width: screenW,
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Call the loginUser function to handle the API request
                              setState(() {
                                isLoading = true;
                              });
                              loginUser(emailController.text.toString(),
                                  passwordController.text.toString());
                            } else {
                              Get.snackbar(
                                "",
                                "",
                                titleText: const Text(
                                  "Failed",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                                messageText: const Text(
                                  "Login Failed",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                shouldIconPulse: true,
                                icon: SvgPicture.asset(
                                  "assets/svgs/failed.svg",
                                  height: 25,
                                  width: 25,
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF141E3C),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                ),
              ),
              const Center(
                child: Text(
                  'Signup with',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBDBEDC),
                    fontFamily: 'InterMedium',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 20, top: 20),
                child: SizedBox(
                  height: screenH / 15,
                  width: screenW,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/googlelogo.png",
                      height: 40,
                    ),
                    label: const Text('Google',
                        style: TextStyle(
                            color: Color.fromARGB(255, 135, 135, 153),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Inter')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFBDBEDC)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'By signing up, you agree to our',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF141E3C),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          fontSize: 12),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms & Conditions ',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(
                                color: Color(0xFFFF1B6F),
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          const TextSpan(
                            text: 'and ',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: 'Privacy policy',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(
                                color: Color(0xFFFF1B6F),
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
