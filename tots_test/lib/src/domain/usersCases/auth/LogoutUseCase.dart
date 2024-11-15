import 'package:tots_test/src/domain/repository/AuthRepository.dart';

class LogoutUseCase {

  AuthRepository repository;

  LogoutUseCase(this.repository);

  run() =>  repository.logout();
}