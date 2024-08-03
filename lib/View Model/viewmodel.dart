// import 'package:flutter/material.dart';
// import 'package:lilacmachinetest/provider/Apiservice.dart';
// // import 'package:your_app/Providers/api.dart'; // Update with the actual path to your ApiService

// class DataViewModel extends ChangeNotifier {
//   final ApiService apiService;
//   bool _isLoading = false;
//   Map<String, dynamic>? _data;
//   String? _errorMessage;

//   DataViewModel({required this.apiService}) {
//     fetchData(); // Automatically fetch data when the view model is created
//   }

//   bool get isLoading => _isLoading;
//   Map<String, dynamic>? get data => _data;
//   String? get errorMessage => _errorMessage;

//   void fetchData() {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     apiService.get(
//       'therapist/privacy/policy', // Endpoint to fetch privacy policy
//       (responseData) {
//         _data = responseData;
//         _isLoading = false;
//         notifyListeners();
//       },
//       (error) {
//         _errorMessage = error;
//         _isLoading = false;
//         notifyListeners();
//       },
//     );
//   }
// }
