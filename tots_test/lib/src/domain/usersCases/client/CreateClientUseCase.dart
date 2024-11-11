import 'dart:io';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/repository/ClientRepository.dart';

class CreateClientUseCase {
  final ClientRepository clientRepository;

  CreateClientUseCase(this.clientRepository);

  run(Client client) => clientRepository.create(client);
}
