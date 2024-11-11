import 'package:tots_test/src/domain/repository/ClientRepository.dart';

class DeleteClientUseCase{

  ClientRepository clientRepository;

  DeleteClientUseCase(this.clientRepository);

  run(int id) => clientRepository.delete(id);
}