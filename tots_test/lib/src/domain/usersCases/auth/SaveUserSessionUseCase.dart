import 'package:tots_test/src/domain/models/AuthResponse.dart';
import 'package:tots_test/src/domain/repository/AuthRepository.dart';

class SaveUserSessionUseCase{

  AuthRepository authRepository;
  SaveUserSessionUseCase(this.authRepository);

  run(AuthResponse authResponse) => authRepository.saveUserSession(authResponse);


}