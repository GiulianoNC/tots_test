import 'package:tots_test/src/data/dataSource/local/SharedPref.dart';
import 'package:tots_test/src/data/dataSource/remote/services/AuthService.dart';
import 'package:tots_test/src/domain/models/AuthResponse.dart';
import 'package:tots_test/src/domain/models/User.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/domain/repository/AuthRepository.dart';

class Authrepositoryimpl implements AuthRepository {

  Authservice authservice;
  SharedPref sharedPref;

  Authrepositoryimpl(this.authservice,this.sharedPref);//con esta inyeccion, insertamos todos los metodos de authservice

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authservice.login(email, password);
  }

  @override
  Future<Resource<AuthResponse>> register(User user) {
    return authservice.register(user);
  }
  
  @override
  Future<AuthResponse?> getUserSession()async {
    final data = await sharedPref.read('user');
    if(data != null){
      AuthResponse authResponse = AuthResponse.fromJson(data);
      return authResponse;
    }
    return null;
  }
  
  @override
  Future<void> saveUserSession(AuthResponse authResponse)async {
    sharedPref.save('user',  authResponse.toJson());
    
  }
  
  @override
  Future<bool?> logout()async {
    await sharedPref.remove('user');  
  }




}