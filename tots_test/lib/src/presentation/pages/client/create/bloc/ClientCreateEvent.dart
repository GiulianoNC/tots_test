import 'package:equatable/equatable.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';

abstract class ClientCreateEvent extends Equatable {
  const ClientCreateEvent();
  @override
  List<Object?> get props => [];
}

class ClientCreateInitEvent extends ClientCreateEvent {
   const ClientCreateInitEvent();
}

class FirstNameChanged extends ClientCreateEvent {
  final BlocFormItem firstname;
  const FirstNameChanged({required this.firstname});
  @override
  List<Object?> get props => [firstname];
}

class LastNameChanged extends ClientCreateEvent {
  final BlocFormItem lastname;
  const LastNameChanged({required this.lastname});
  @override
  List<Object?> get props => [lastname];
}

class EmailChanged extends ClientCreateEvent {
  final BlocFormItem email;
  const EmailChanged({required this.email});
  @override
  List<Object?> get props => [email];
}

class CreateFormSubmit extends ClientCreateEvent {
  const CreateFormSubmit();
}

class ClientFormReset extends ClientCreateEvent {
  const ClientFormReset();
  @override
  List<Object?> get props =>[] ;
}

class PickImage extends ClientCreateEvent {
  const PickImage();
}

class TakePhoto extends ClientCreateEvent {}
