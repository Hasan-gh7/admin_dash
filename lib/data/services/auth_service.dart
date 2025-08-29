class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return email == "hasan" && password == "123456";
  }
}

//      admin@realestate.com