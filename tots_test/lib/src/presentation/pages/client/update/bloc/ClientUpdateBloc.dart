import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/usersCases/client/ClientUseCases.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateEvent.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateState.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';
import 'package:image_picker/image_picker.dart';

class ClientUpdateBloc extends Bloc<ClientUpdateEvent, ClientUpdateState>{

  ClientUsesCases clientUsesCases;
 
  
  
  final formKey = GlobalKey<FormState>();

  ClientUpdateBloc(this.clientUsesCases):super(ClientUpdateState()){
    on<ClientUpdateInitEvent>(_onClientUpdateInitEvent);
    on<ClientUpdateFirstNameChanged>(_onFirstNameChanged);
    on<ClientUpdateLastNameChanged>(_onLastNameChanged);
    on<ClientUpdateEmailChanged>(_onEmailChanged);
    on<ClientUpdatePickImage>(_onPickImage);
    on<ClientUpdateTakePhoto>(_onTakePhoto);
    on<ClientUpdateFormSubmit>(_onFormSubmit);
    on<ResetForm>(_onResetForm);
    on<ClientDelete>(_onDeleteClient);
  

  }

  Future<void>?_onClientUpdateInitEvent(ClientUpdateInitEvent event, Emitter<ClientUpdateState>emit){
    emit(
      state.copyWith(
        id:event.client?.id,
        firstname:BlocFormItem(value: event.client?.firstname ?? ''),
        lastname:BlocFormItem(value: event.client?.lastname ?? ''),
        email:BlocFormItem(value: event.client?.email ?? ''),
        formKey: formKey
      )
    );
  } 

  Future<void> _onFormSubmit(ClientUpdateFormSubmit event, Emitter<ClientUpdateState> emit) async {
    emit(
      state.copyWith(
        response: Loading(),
        formKey: formKey,
      ),
    );

    Client updatedClient = state.toClient().copyWith(
      photo: state.imagePath, 
    );

    
    Resource response = await clientUsesCases.update.run(state.id, updatedClient);

    emit(
      state.copyWith(
        response: response,
        formKey: formKey,
      ),
    );
  }

  Future<void>?_onFirstNameChanged(ClientUpdateFirstNameChanged event, Emitter<ClientUpdateState>emit){
    emit(
      state.copyWith(
        firstname: BlocFormItem(
          value:event.firstname.value,
          error: event.firstname.value.isNotEmpty? null: 'Ingresa el nombre'
        ),
        formKey: formKey
      )
    );
  }

  Future<void>?_onLastNameChanged(ClientUpdateLastNameChanged event, Emitter<ClientUpdateState>emit){
    emit(
      state.copyWith(
        lastname: BlocFormItem(
          value:event.lastname.value,
          error: event.lastname.value.isNotEmpty? null: 'Ingresa el apellido'
        ),
        formKey: formKey
      )
    );
  }

  Future<void>?_onEmailChanged(ClientUpdateEmailChanged event, Emitter<ClientUpdateState>emit){
    emit(
      state.copyWith(
        email: BlocFormItem(
          value:event.email.value,
          error: event.email.value.isNotEmpty? null: 'Ingresa el email'
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onPickImage(ClientUpdatePickImage event, Emitter<ClientUpdateState> emit) async {
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

Future<void> _onTakePhoto(ClientUpdateTakePhoto event, Emitter<ClientUpdateState> emit) async {
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


  Future<void> _onResetForm(ResetForm event, Emitter<ClientUpdateState> emit) async {
    emit(state.copyWith(
      file: null,  
      firstname: BlocFormItem(value: ''),
      lastname: BlocFormItem(value: ''),
      email: BlocFormItem(value: ''),
    ));
  }


  
  Future<void> _onDeleteClient(ClientDelete event, Emitter<ClientUpdateState> emit) async {
    try {
      emit(state.copyWith(response: Loading())); // Estado de carga
      Resource response = await clientUsesCases.delete.run(event.id);
      emit(state.copyWith(response: response));

      // Después de eliminar el cliente, recargar la lista o resetear el formulario.
      add(ResetForm()); // Reinicia el formulario

      // Si tienes un Bloc o Provider para la lista de clientes, emite un evento para actualizar la lista
      // Puedes agregar un evento para recargar la lista de clientes aquí, si es necesario.
    } catch (e) {
      print('Error al eliminar el cliente: $e');
    }
  }

 
}
