import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tots_test/src/data/dataSource/local/SharedPref.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/utils/ListToString.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/data/api/ApiConfig.dart';

class ClientService {

  final SharedPref _sharedPref = SharedPref();

  Future<String> getToken() async {
    return await _sharedPref.read('access_token') ?? '';
  }

  final Future<String> token;
  ClientService(this.token);
  
  Future<Resource<List<Client>>> fetchClients(int page, {String searchQuery = ''}) async {
    try {
      final tokenValue = await getToken();
      print("Token value: $tokenValue");

      final url = Uri.parse('${Apiconfig.API_TOTS}/clients?page=$page&limit=5&search=$searchQuery');
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $tokenValue"
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Client> clients = (data['data'] as List)
            .map((clientJson) => Client.fromJson(clientJson))
            .toList();
        return Success(clients);
      } else {
        return Error("Error: ${response.statusCode}");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Client>> create(client) async {
    try {
      final url = Uri.parse('${Apiconfig.API_TOTS}/clients');
      final tokenValue = await getToken();

      // Crear el cuerpo JSON de la solicitud
      final Map<String, dynamic> body = {
        "firstname": client.firstname,
        "lastname": client.lastname,
        "email": client.email ?? '',
        "address": client.address ?? '',
        "photo": client.photo ?? '', 
        "caption": client.caption ?? '',
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenValue',
        },
        body: jsonEncode(body),
      );

      // Manejar la respuesta
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final categoryResponse = Client.fromJson(data);
        return Success(categoryResponse);
      } else {
        final data = jsonDecode(response.body);
        return Error(data['message'] ?? 'Error desconocido en la creación de cliente');
      }
    } catch (e) {
      print('Error: $e');
      return Error(e.toString());
    }
  }

  Future<Resource<Client>> update(int id, Client client) async {
    try {
      // Obtiene el token de SharedPref de manera asincrónica
      final token = await _sharedPref.read('access_token');
      
      if (token == null || token.isEmpty) {
        return Error('No se ha encontrado un token válido');
      }

      Uri url = Uri.parse('${Apiconfig.API_TOTS}/clients/$id');

      // Configura los headers para la solicitud
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token',  // Usa el token obtenido de SharedPref
      };

      // Crea el cuerpo de la solicitud con los datos del cliente
      String body = json.encode({
        'firstname': client.firstname ?? '',
        'lastname': client.lastname ?? '',
        'email': client.email ?? '',
        'address': client.address ?? '',
        'photo': client.photo ?? '', 
        'caption': client.caption ?? '',
      });

      // Realiza la solicitud PUT
      final response = await http.put(url, headers: headers, body: body);

      // Procesa la respuesta
      final data = jsonDecode(response.body);

      // Verifica si la solicitud fue exitosa
      if (response.statusCode == 200 || response.statusCode == 201) {
        Client clientResponse = Client.fromJson(data);
        return Success(clientResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> delete(int id) async {
    try {
      // Obtiene el token de SharedPref de manera asincrónica
      final token = await _sharedPref.read('access_token');
      
      if (token == null || token.isEmpty) {
        return Error('No se ha encontrado un token válido');
      }

      Uri url = Uri.parse('${Apiconfig.API_TOTS}/clients/$id');
      
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token',  // Usa el token obtenido de SharedPref
      };

      final response = await http.delete(url, headers: headers);
      final data = jsonDecode(response.body);
      print('Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      print('Error $e');
      return Error(e.toString());
    }
  }


  
}




