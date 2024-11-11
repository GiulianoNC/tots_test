import 'package:tots_test/src/domain/models/User.dart';
import 'package:tots_test/src/domain/repository/AuthRepository.dart';

class Registerusecase {

  AuthRepository repository;
  Registerusecase(this.repository);

  run(User user)
   => repository.register(user);
}