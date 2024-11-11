import 'package:equatable/equatable.dart';
import 'package:tots_test/src/domain/models/Client.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object?> get props => [];
}

class InitEventClient extends ClientEvent {
  const InitEventClient();
}

class FetchClients extends ClientEvent {
  final int page;
  final String searchQuery;

  const FetchClients(this.page, {this.searchQuery = ''});

  @override
  List<Object?> get props => [page, searchQuery];
}

class AddClient extends ClientEvent {
  final Client client;

  const AddClient(this.client);

  @override
  List<Object?> get props => [client];
}

class UpdateClient extends ClientEvent {
  final int clientId;
  final Client client;

  const UpdateClient(this.clientId, this.client);

  @override
  List<Object?> get props => [clientId, client];
}

class DeleteClient extends ClientEvent {
  final int id;

  const DeleteClient({required this.id});

  @override
  List<Object?> get props => [id];
}


class Logout extends ClientEvent{
  const Logout();
  
}
