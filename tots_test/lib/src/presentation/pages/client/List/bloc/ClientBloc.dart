import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/usersCases/auth/AuthUseCases.dart';
import 'package:tots_test/src/domain/usersCases/client/ClientUseCases.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientEvent.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientState.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientUsesCases clientUsesCases;

  Authusecases authusecases;

  ClientBloc(this.clientUsesCases, this.authusecases) : super(ClientState()) {
    on<InitEventClient>(_onInitEvent);
    on<FetchClients>(_onFetchClients);
    on<Logout> (_onLogout);
  }

  Future<void> _onInitEvent(InitEventClient event, Emitter<ClientState> emit) async {
    emit(state.copyWith(response: Loading())); // Estado de carga inicial
    Resource<List<Client>>? response = await clientUsesCases.fetchClients.run(1); // Cargar la primera página
    emit(state.copyWith(response: response)); 
  }

  Future<void> _onFetchClients(FetchClients event, Emitter<ClientState> emit) async {
    emit(state.copyWith(response: Loading())); // Emitimos el estado de carga
    
    // Ejecuta la llamada al caso de uso y obtiene los clientes
    Resource<List<Client>>? response = await clientUsesCases.fetchClients.run(event.page, searchQuery: event.searchQuery);

    // Verificamos si la respuesta es de tipo Success y contiene datos no nulos
    if (response is Success<List<Client>> && response.data != null) {
      final List<Client> data = response.data!; // Asignamos a una variable local segura
      
      // Filtramos si el query de búsqueda no está vacío
      final filteredClients = event.searchQuery.isNotEmpty
          ? data.where((client) => 
              client.firstname != null &&
              client.firstname!.toLowerCase().contains(event.searchQuery.toLowerCase())
            ).toList()
          : data;
      
      // Emitimos el estado con los clientes filtrados o sin filtrar
      emit(state.copyWith(response: Success(filteredClients)));
    } else {
      // En caso de error o datos nulos, emitimos la respuesta original
      emit(state.copyWith(response: response));
    }
  }
 
 Future<void> _onLogout(Logout event, Emitter<ClientState> emit) async {
   await authusecases.logout.run();
   emit(state.copyWith(response: Success([])));
}


}

