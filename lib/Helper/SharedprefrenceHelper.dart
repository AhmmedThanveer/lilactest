import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreferencehelper {
  Future<bool> setAuthToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(UserPref.AuthToken.toString(), token);
  }

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(UserPref.AuthToken.toString());
  }

//   Future<void> clearTokens() async {
//     final pref = await SharedPreferences.getInstance();
//     await pref.remove(UserPref.firebaseAuthToken.toString());
//     await pref.remove(UserPref.laravelAuthToken.toString());
//     await pref.remove(UserPref.firstName.toString());
//     await pref.remove(UserPref.lastName.toString());
//     await pref.remove(UserPref.alternativeemail.toString());
//     await pref.remove(UserPref.alternativephone.toString());
//     await pref.remove(UserPref.balance.toString());
//     await pref.remove(UserPref.countrycode.toString());
//     await pref.remove(UserPref.dob.toString());
//     await pref.remove(UserPref.emailId.toString());
//     await pref.remove(UserPref.gender.toString());
//     await pref.remove(UserPref.image.toString());
//     await pref.remove(UserPref.mobileNumber.toString());
//     await pref.remove(UserPref.userId.toString());
//     await pref.remove(UserPref.currecy.toString());
//     await pref.remove(UserPref.currencyCode.toString());
//   }
// }
}

enum UserPref {
  AuthToken,
}

class SPService {
  static late SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static void clear() {
    instance.clear();
  }
}
