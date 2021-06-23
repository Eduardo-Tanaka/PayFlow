import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nlw2021/shared/auth/auth_controller.dart';
import 'package:nlw2021/shared/models/user_model.dart';

class LoginController {
  Future<void> googleSingIn(BuildContext context) async {
    var authController = AuthController();

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      print(response);
      final user =
          UserModel(name: response!.displayName!, photoUrl: response.photoUrl);
      authController.setUser(context, user);
    } catch (error) {
      print(error);
    }
  }
}
