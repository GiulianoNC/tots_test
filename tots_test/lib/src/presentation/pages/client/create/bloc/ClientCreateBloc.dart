import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/usersCases/client/ClientUseCases.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateEvent.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateState.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';


class ClientCreateBloc extends Bloc<ClientCreateEvent, ClientCreateState> {
  final ClientUsesCases clientUsesCases;
  final formKey = GlobalKey<FormState>();

  ClientCreateBloc(this.clientUsesCases) : super(ClientCreateState()) {
    on<ClientCreateInitEvent>(_onInitEvent);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<ClientCreatePickImage>(_onPickImage);
    on<ClientCreateTakePhoto>(_onTakePhoto);
    on<CreateFormSubmit>(_onCreateFormSubmit);
     on<ClientFormReset>(_onFormCreateReset);
  }

  Future<void>? _onInitEvent(ClientCreateInitEvent event, Emitter<ClientCreateState> emit) {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void>? _onFirstNameChanged(FirstNameChanged event, Emitter<ClientCreateState> emit) {
    emit(
      state.copyWith(
        firstname: BlocFormItem(
          value: event.firstname.value,
          error: event.firstname.value.isNotEmpty ? null : "Ingresa el nombre"
          ),
          
        formKey: formKey
    ));
  }

  Future<void>? _onLastNameChanged(LastNameChanged event, Emitter<ClientCreateState> emit) {
    emit(
      state.copyWith(
        lastname: BlocFormItem(
          value: event.lastname.value,
          error: event.lastname.value.isNotEmpty  ? null : "Ingresa el apellido"
          ),
          
        formKey: formKey
    ));
  }

  Future<void>? _onEmailChanged(EmailChanged event, Emitter<ClientCreateState> emit) {
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty && event.email.value.length >= 6  ? null : "Ingresa el email"
          ),
          
        formKey: formKey
    ));
  }

 

  Future<void> _onCreateFormSubmit (CreateFormSubmit event, Emitter<ClientCreateState> emit) async{
    emit(
      state.copyWith(
        response: Loading(),
        formKey: formKey
      )
    );
    Client createClient = state.toClient().copyWith(
      photo: state.imagePath, 
    );
    Resource response = await clientUsesCases.create.run(createClient);
    emit(
      state.copyWith(
        response: response,
        formKey: formKey
        ),
      );

      
  }  

   Future<void> _onPickImage(ClientCreatePickImage event, Emitter<ClientCreateState> emit) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    emit(
      state.copyWith(
        file: File(image.path),
        imagePath: image.path, 
        formKey: formKey,
      ),
    );
  }
}

Future<void> _onTakePhoto(ClientCreateTakePhoto event, Emitter<ClientCreateState> emit) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    emit(
      state.copyWith(
        file: File(image.path),
        imagePath: image.path, 
        formKey: formKey,
      ),
    );
  }
}


  Future<void>? _onFormCreateReset(ClientFormReset event, Emitter<ClientCreateState> emit) {
  // Emitir un nuevo estado con los valores por defecto para reiniciar el formulario
  emit(state.ClientResetForm());
}



}



