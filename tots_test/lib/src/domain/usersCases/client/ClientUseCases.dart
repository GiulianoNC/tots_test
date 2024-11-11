import 'package:tots_test/src/domain/usersCases/client/CreateClientUseCase.dart';
import 'package:tots_test/src/domain/usersCases/client/DeleteClientUseCase.dart';
import 'package:tots_test/src/domain/usersCases/client/GetClientUseCase.dart';
import 'package:tots_test/src/domain/usersCases/client/UpdateClientUseCase.dart';

class ClientUsesCases{
  
  CreateClientUseCase create;
  GetClientsUseCase fetchClients; 
  UpdateClientUseCase update;
  DeleteClientUseCase delete;
  

  ClientUsesCases({
    required this.fetchClients,
    required this.create,
    required this.update,
    required this.delete
  });
}