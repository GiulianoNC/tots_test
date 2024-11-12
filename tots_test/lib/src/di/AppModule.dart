import 'package:injectable/injectable.dart';
import 'package:tots_test/src/data/dataSource/local/SharedPref.dart';
import 'package:tots_test/src/data/dataSource/remote/services/AuthService.dart';
import 'package:tots_test/src/data/dataSource/remote/services/ClientService.dart';
import 'package:tots_test/src/data/repository/AuthRepositoryImpl.dart';
import 'package:tots_test/src/data/repository/ClientRepositoryImpl.dart';
import 'package:tots_test/src/domain/models/AuthResponse.dart';
import 'package:tots_test/src/domain/repository/AuthRepository.dart';
import 'package:tots_test/src/domain/repository/ClientRepository.dart';
import 'package:tots_test/src/domain/usersCases/auth/AuthUseCases.dart';
import 'package:tots_test/src/domain/usersCases/auth/GetUserSessionUseCase.dart';
import 'package:tots_test/src/domain/usersCases/auth/LoginUseCase.dart';
import 'package:tots_test/src/domain/usersCases/auth/LogoutUseCase.dart';
import 'package:tots_test/src/domain/usersCases/auth/RegisterUseCase.dart';
import 'package:tots_test/src/domain/usersCases/auth/SaveUserSessionUseCase.dart';
import 'package:tots_test/src/domain/usersCases/client/ClientUseCases.dart';
import 'package:tots_test/src/domain/usersCases/client/CreateClientUseCase.dart';
import 'package:tots_test/src/domain/usersCases/client/DeleteClientUseCase.dart';
import 'package:tots_test/src/domain/usersCases/client/GetClientUseCase.dart';
import 'package:get_it/get_it.dart';
import 'package:tots_test/src/domain/usersCases/client/UpdateClientUseCase.dart';

final getIt = GetIt.instance;
@module
abstract class Appmodule {

  @injectable
  SharedPref get sharedPred => SharedPref();

  @injectable
  Future<String> get token async {
    String token = '';
    final userSession = await sharedPred.read('user');
    if (userSession != null) {
      AuthResponse authResponse = AuthResponse.fromJson(userSession);
      token = authResponse.accessToken;
    }
    return token;
  }

  @injectable
  Authservice get authservice => Authservice();
  
  @injectable
  AuthRepository get authRepository => Authrepositoryimpl(authservice,sharedPred);

  @injectable
    Authusecases get authusecases => Authusecases(
      login: LoginUsecase(authRepository),
      resgister: Registerusecase(authRepository),
      saveUserSession: SaveUserSessionUseCase(authRepository),
      getUserSession: GetUserSessionUseCase(authRepository),
      logout: LogoutUseCase(authRepository)
    );
  
  @injectable
  ClientService get clientService => ClientService(getToken());

  Future<String> getToken() async {
    String token = '';
    final userSession = await sharedPred.read('user');
    if (userSession != null) {
      AuthResponse authResponse = AuthResponse.fromJson(userSession);
      token = authResponse.accessToken;
    }
    return token;
  }
  

  @injectable
  ClientRepository get clientRepository => ClientRepositoryImpl(clientService); 

  @injectable
  ClientUsesCases get clientUsesCases => ClientUsesCases(
    fetchClients: GetClientsUseCase(clientRepository),
    create: CreateClientUseCase(clientRepository),
    update: UpdateClientUseCase(clientRepository),
    delete: DeleteClientUseCase(clientRepository) 
  );
}