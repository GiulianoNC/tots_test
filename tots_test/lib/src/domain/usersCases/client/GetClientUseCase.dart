import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/repository/ClientRepository.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';

class GetClientsUseCase {
  final ClientRepository clientRepository;

  GetClientsUseCase(this.clientRepository);

  Future<Resource<List<Client>>?> run(int page, {String searchQuery = ''}) async {
    return await clientRepository.fetchClients(page, searchQuery: searchQuery);
  }
}

