import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilacmachinetest/Helper/SharedprefrenceHelper.dart';
import 'package:lilacmachinetest/View%20Model/viewmodel.dart';
import 'package:lilacmachinetest/View/Screens/Login%20Screen/Loginscreen.dart';
import 'package:lilacmachinetest/View/Screens/Tabmanager%20Screen/tabmanagerscreen.dart';
import 'package:lilacmachinetest/provider/Apiservice.dart';
import 'package:provider/provider.dart';
// import 'package:api/screens/main_screen/screen.dart'; // Update with the actual path
// import 'package:your_app/view_models/data_view_model.dart'; // Update with the actual path
// import 'package:your_app/Providers/api.dart'; // Update with the actual path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<Widget> _getInitialScreen() async {
    final token = await Sharedpreferencehelper().getAuthToken();

    if (token != null && token.isNotEmpty) {
      return const Tabmanagerscreen(); // Navigate to TabManagerScreen if token is present
    } else {
      return LoginScreen(); // Navigate to LoginScreen if token is not present
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ); // Show a loading indicator while checking the token
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ); // Handle errors if any
          } else {
            return snapshot.data ??
                LoginScreen(); // Return the appropriate screen
          }
        },
      ),
    );
  }
}
