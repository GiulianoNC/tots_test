import 'package:tots_test/src/domain/usersCases/auth/GetUserSessionUseCase.dart';
import 'package:tots_test/src/domain/usersCases/auth/LoginUseCase.dart';
import 'package:tots_test/src/domain/usersCases/auth/LogoutUseCase.dart';
import 'package:tots_test/src/domain/usersCases/auth/RegisterUseCase.dart';
import 'package:tots_test/src/domain/usersCases/auth/SaveUserSessionUseCase.dart';

//ALMACENAR TODOS LOS CASOS DE USOS
class Authusecases {

  LoginUsecase login;
  Registerusecase resgister;
  SaveUserSessionUseCase saveUserSession;
  GetUserSessionUseCase getUserSession;
  LogoutUseCase logout;

  Authusecases({
    required this.login,
    required this.resgister,
    required this.getUserSession,
    required this.saveUserSession,
    required this.logout
  });
}