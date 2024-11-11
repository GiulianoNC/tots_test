import 'package:tots_test/src/data/dataSource/remote/services/ClientService.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/repository/ClientRepository.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';


class ClientRepositoryImpl implements ClientRepository {
  final ClientService clientService;

  ClientRepositoryImpl(this.clientService);

  @override
  Future<Resource<List<Client>>>? fetchClients(int page, {String searchQuery = ''}) {
    return clientService.fetchClients(page, searchQuery: searchQuery); 
  }

  @override
  Future<Resource<Client>> create(Client client) {
    return clientService.create( client);
  }

  @override
  Future<Resource<Client>> update(int id, Client client) {
    return clientService.update(id, client);  
  }

  @override
  Future<Resource<bool>>? delete(int id) {
    return clientService.delete(id);
  }
}



