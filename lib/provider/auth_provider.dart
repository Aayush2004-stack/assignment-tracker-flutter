import 'package:assignment_tracker/model/user_model.dart';
import 'package:assignment_tracker/services/auth_service.dart';
import 'package:flutter/widgets.dart';


class AuthProvider extends ChangeNotifier{

  

    AuthProvider({AuthService? authService})
    : _authService = authService ?? AuthService();

    final AuthService _authService;

    bool isLoading = false;
    String? errorMessage;
    UserModel? user;
    String? userToken;


Future<bool> login({
  required String email, required String password
})async {
  isLoading = true;
  errorMessage= null;
  notifyListeners();

  try{
    final response = await _authService.login(email, password);
    userToken = response.userToken;
    return true;
  }
  catch(err){
    errorMessage = err.toString();
    return false;
  }
  finally{
    isLoading= false;
    notifyListeners();
  }

}
void logout(){
  userToken=null;
  user=null;
  errorMessage = null;
}

  
}

