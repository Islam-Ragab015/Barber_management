import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // setmail in SharedPreferences function
  static Future<bool> setEmail(String value) async {
    return await prefs?.setString('email', value) ?? false;
  }

  static String? getEmail() {
    return prefs?.getString(
      'email',
    );
  }

  static testSharedPreferences() async {
    print('token  ${prefs?.getString('token')}');
    print('user_id  ${prefs?.getString('user_id')}');
    print('labels  ${prefs?.getString('labels')}');
  }
}
