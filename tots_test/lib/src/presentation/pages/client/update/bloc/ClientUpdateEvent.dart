import 'package:equatable/equatable.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';

abstract class ClientUpdateEvent extends Equatable{

  const  ClientUpdateEvent();

  @override
  List<Object?> get props => [];
  
}

class ClientUpdateInitEvent extends ClientUpdateEvent{
  final Client? client;
  const ClientUpdateInitEvent({required this.client});

  @override
  List<Object?> get props => [client];
}

class ClientUpdateFirstNameChanged extends ClientUpdateEvent{

  final BlocFormItem firstname;
  const ClientUpdateFirstNameChanged({required this.firstname});
  @override
  List<Object?> get props => [firstname];
}

class ClientUpdateLastNameChanged extends ClientUpdateEvent{

  final BlocFormItem lastname;
  const ClientUpdateLastNameChanged({required this.lastname});
  @override
  List<Object?> get props => [lastname];
}

class ClientUpdateEmailChanged extends ClientUpdateEvent{

  final BlocFormItem email;
  const ClientUpdateEmailChanged({required this.email});
  @override
  List<Object?> get props => [email];
}

class ClientUpdateFormSubmit extends ClientUpdateEvent {
  const ClientUpdateFormSubmit();
}

class ResetForm extends ClientUpdateEvent{
  const ResetForm();
  @override
  List<Object?> get props =>[] ;
}

class ClientUpdatePickImage extends ClientUpdateEvent {
  const ClientUpdatePickImage();
}

class ClientUpdateTakePhoto extends ClientUpdateEvent {
  const ClientUpdateTakePhoto();
}

class ClientDelete extends ClientUpdateEvent{
  final int id;

  const ClientDelete({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}

class Logout extends ClientUpdateEvent{
  const Logout();
  
}