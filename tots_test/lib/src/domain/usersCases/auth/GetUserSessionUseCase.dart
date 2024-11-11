import 'package:tots_test/src/domain/repository/AuthRepository.dart';

class GetUserSessionUseCase{

  AuthRepository authRepository;
  GetUserSessionUseCase(this.authRepository);

  run() => authRepository.getUserSession();


}