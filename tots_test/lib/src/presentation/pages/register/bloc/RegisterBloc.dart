import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/domain/usersCases/auth/AuthUseCases.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterEvent.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterState.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  Authusecases authusecases;
  
  RegisterBloc(this.authusecases): super(RegisterState()){
    on<RegisterInitEvent>(_onInitEvent);
    on<RegisterFirstNameChanged>(_onNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPassword);
    on<RegisterFormSubmit>(_onFormSubmit);
    on<RegisterFormReset>(_onFormReset);    
  }

  final formKey = GlobalKey<FormState>();  

  Future<void> _onInitEvent (RegisterInitEvent event, Emitter<RegisterState> emit) async{
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onNameChanged (RegisterFirstNameChanged event, Emitter<RegisterState> emit) async{
    emit(
      state.copyWith(
        firstName: BlocFormItem(
          value: event.firstName.value,
          error: event.firstName.value.isNotEmpty   ? null : "Input first name"
          ),
          
        formKey: formKey
    ));    
  } 

  Future<void> _onEmailChanged (RegisterEmailChanged event, Emitter<RegisterState> emit) async{
  emit(
    state.copyWith(
      email: BlocFormItem(
        value: event.email.value,
        error: event.email.value.isNotEmpty ? null : "Input email"
        ),
      formKey: formKey
  ));
  }


  Future<void> _onPasswordChanged (RegisterPasswordChanged event, Emitter<RegisterState> emit) async{
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: event.password.value.isNotEmpty  ? null : "Input password"
          ),
          
        formKey: formKey
    ));
  }

  Future<void> _onConfirmPassword(RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) async {
    String? error;

    emit(
      state.copyWith(
        confirmPassword: BlocFormItem(
          value: event.confirmPassword.value,
          error: error
        ),
        formKey: formKey
      )
    );
  }


  Future<void> _onFormSubmit(RegisterFormSubmit event, Emitter<RegisterState> emit) async {
    // Primero, verifica si las contraseñas coinciden antes de hacer cualquier otra cosa
    if (state.password.value != state.confirmPassword.value) {
      Fluttertoast.showToast(
        msg: 'Passwords do not match',
        toastLength: Toast.LENGTH_LONG,
      );
      return;  // Salir si las contraseñas no coinciden
    }

    // Emitir el estado de carga
    emit(state.copyWith(
      response: Loading(),
      formKey: formKey,
    ));

    try {
      // Realizar la solicitud de registro
      Resource response = await authusecases.resgister.run(state.toUser());

      // Emitir el estado con la respuesta de la API
      emit(state.copyWith(
        response: response,
        formKey: formKey,
      ));

      // Dependiendo del tipo de respuesta, mostrar el mensaje correspondiente
      if (response is Success) {
        Fluttertoast.showToast(
          msg: 'Successful registration',
          toastLength: Toast.LENGTH_LONG,
        );
        // Aquí puedes agregar el redireccionamiento a la página de login si es necesario
      } else if (response is Error) {
        Fluttertoast.showToast(
          msg: response.message ?? 'Error during registration',
          toastLength: Toast.LENGTH_LONG,
        );
      }

    } catch (e) {
      // Manejo de excepciones
      Fluttertoast.showToast(
        msg: 'An unexpected error occurred',
        toastLength: Toast.LENGTH_LONG,
      );
      emit(state.copyWith(
        response: Error( 'An unexpected error occurred'),
        formKey: formKey,
      ));
    }
  }


  Future<void> _onFormReset (RegisterFormReset event, Emitter<RegisterState> emit) async{
    state.formKey?.currentState?.reset();
  }   

}