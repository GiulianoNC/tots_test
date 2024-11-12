import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tots_test/src/data/api/ApiConfig.dart';
import 'package:tots_test/src/data/dataSource/local/SharedPref.dart';
import 'package:tots_test/src/domain/models/AuthResponse.dart';
import 'package:tots_test/src/domain/utils/ListToString.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';

class Authservice {
  final SharedPref _sharedPref = SharedPref();
  //METODO LOGIN
  Future<Resource<AuthResponse>> login (String email, String password)async{
    try {
      Uri url = Uri.parse('${Apiconfig.API_TOTS}/oauth/token');
      Map<String, String> headers ={"Content-Type": "application/json"};
      String body = json.encode({
        'email': email,
        'password': password
      });
      final response = await  http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if(response.statusCode == 200 || response.statusCode == 201){//EXITOSA
        AuthResponse authResponse = AuthResponse.fromJson(data);
        await _sharedPref.save('access_token', authResponse.accessToken);//guardar token
        
        return Success(authResponse);
      }else{
        return Error(listToString(data['message']));//ERROR
      }
    } catch (e) {
      print('Error $e' );
      return Error(e.toString());
    }
  }

  //REGISTER
    Future<Resource<AuthResponse>> register (user)async{
    try {
      Uri url = Uri.parse('${Apiconfig.API_TOTS}/users');
      Map<String, String> headers ={"Content-Type": "application/json"};
      String body = json.encode(user);
      final response = await  http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if(response.statusCode == 200 || response.statusCode == 201){//EXITOSA
        AuthResponse authResponse = AuthResponse.fromJson(data);
        return Success(authResponse);
      }else{
        print(listToString(data['message']).toString());
        return Error(listToString(data['message']));//ERROR
      }
    } catch (e) {
      print('Error $e' );
      return Error(e.toString());
    }
  }
}