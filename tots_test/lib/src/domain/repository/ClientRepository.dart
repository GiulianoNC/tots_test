import 'dart:io';

import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';

abstract class ClientRepository {
  Future<Resource<Client>> create(Client client);
  Future<Resource<List<Client>>>? fetchClients(int page, {String searchQuery = ''});
  Future<Resource<Client>>? update(int id, Client client);
  Future<Resource<bool>>? delete(int id);
}
