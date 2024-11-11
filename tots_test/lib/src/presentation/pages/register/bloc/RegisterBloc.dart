import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          error: event.firstName.value.isNotEmpty && event.firstName.value.length >= 6  ? null : "Ingesa el nombre"
          ),
          
        formKey: formKey
    ));    
  } 

  Future<void> _onEmailChanged (RegisterEmailChanged event, Emitter<RegisterState> emit) async{
  emit(
    state.copyWith(
      email: BlocFormItem(
        value: event.email.value,
        error: event.email.value.isNotEmpty ? null : "Ingresa el email"
        ),
      formKey: formKey
  ));
  }


  Future<void> _onPasswordChanged (RegisterPasswordChanged event, Emitter<RegisterState> emit) async{
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: event.password.value.isNotEmpty && event.password.value.length >= 6  ? null : "Ingesa el password"
          ),
          
        formKey: formKey
    ));
  }

  Future<void> _onConfirmPassword (RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) async{
    emit(
      state.copyWith(
        confirmPassword: BlocFormItem(
          value: event.confirmPassword.value,
          error: event.confirmPassword.value.isNotEmpty && event.confirmPassword.value.length >= 6  ? null : "Confirma el password"
          ),
          
        formKey: formKey
    ));        
  }

  Future<void> _onFormSubmit (RegisterFormSubmit event, Emitter<RegisterState> emit) async{
    emit(
      state.copyWith(
        response: Loading(),
        formKey: formKey
      )
    );
    Resource response = await authusecases.resgister.run(state.toUser());
    emit(
      state.copyWith(
        response: response,
        formKey: formKey
        ),
      );
  }  

  Future<void> _onFormReset (RegisterFormReset event, Emitter<RegisterState> emit) async{
    state.formKey?.currentState?.reset();
  }   

}