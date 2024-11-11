import 'dart:io';

import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/repository/ClientRepository.dart';

class UpdateClientUseCase {

  ClientRepository clientRepository;

  UpdateClientUseCase(this.clientRepository);

  run(int id, Client client) => clientRepository.update(id, client);
}