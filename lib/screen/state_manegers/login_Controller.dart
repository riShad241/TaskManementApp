import 'package:get/get.dart';

import '../../data/models/Network_response.dart';
import '../../data/models/auth_utility.dart';
import '../../data/models/loginModel.dart';
import '../../data/services/network_caller.dart';
import '../../utils/url-.dart';

class LoginController extends GetxController {
  bool _logInprogress = false;
  bool get loginProgress => _logInprogress;

  Future<bool> login(String email, String password) async {
    _logInprogress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);
    _logInprogress = false;
    update();
    if (response.issuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtilits.saveUserInfo(model);
      return true;
    } else {
      return false;
    }
  }
}
