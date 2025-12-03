import 'package:aiyurapp/services/auth_service.dart';
import 'package:aiyurapp/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileController {
  UserService _userService = UserService.instance;
  AuthService _authService = AuthService.instance;

  void updateNickname(String nickname) {
    User? user = _authService.getCurrentUser();
    if (user == null) {
      throw Exception("Unauthenticated user.");
    }

    if (nickname.length <= 3 || nickname.length > 16) {
      throw Exception("Invalid nickname.");
    }

    _userService.updateNickname(user.uid, nickname);
  }

  void updateBiography(String biography) {
    User? user = _authService.getCurrentUser();
    if (user == null) {
      throw Exception("Unauthenticated user.");
    }

    if (biography.length > 150) {
      throw Exception("The biography cannot exceed 150 characters.");
    }

    _userService.updateBiography(user.uid, biography);
  }

  String getNickname() {
    User? user = _authService.getCurrentUser();
    if (user == null) {
      throw Exception("Unauthenticated user.");
    }

    String nickname = "";
    _userService.getUserData(user.uid).then((userModel){
      if (userModel != null) nickname = userModel.nickname;
    });
    return nickname;
  }

  String getBiography() {
    User? user = _authService.getCurrentUser();
    if (user == null) {
      throw Exception("Unauthenticated user.");
    }

    String? biography = "";
    _userService.getUserData(user.uid).then((userModel){
      if (userModel != null) biography = userModel.biography;
    });
    return biography != null ? biography! : "";
  }
}