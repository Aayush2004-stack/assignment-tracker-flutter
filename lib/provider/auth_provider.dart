import 'package:assignment_tracker/model/user_model.dart';
import 'package:assignment_tracker/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
    final prefs= await SharedPreferences.getInstance(); // store the token in shared preferences
    await prefs.setString('token', userToken!);
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
Future<bool> isLoggedIn() async{
  final prefs= await SharedPreferences.getInstance();
  final token= prefs.getString('token');

  if(token==null || token.isEmpty){
    userToken = null;
    return false;
  }
  else if(JwtDecoder.isExpired(token)){
    await prefs.remove('token');
    userToken=null;
    return false;
  }
  else{
    userToken = token;
    return true;
  }
}

void logout(){
  userToken=null;
  user=null;
  errorMessage = null;
}

  
}

