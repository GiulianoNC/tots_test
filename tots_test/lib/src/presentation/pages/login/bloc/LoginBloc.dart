import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tots_test/src/domain/models/AuthResponse.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/domain/usersCases/auth/AuthUseCases.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginEvent.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginState.dart';
import 'package:tots_test/src/presentation/utils/BlocForItem.dart';

//MANEJO DE LOS DATOS QUE SE EXTRAEN DE PANTALLA LOGIN
class LoginBloc extends Bloc<LoginEvent,LoginState>{

  Authusecases authusecases;

  LoginBloc(this.authusecases): super(LoginState()){
    on<InitEvent>(_onInitEvent);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmit>(_onLoginSubmit);
    on<LoginFormReset>(_onLoginFormReset);
    on<LoginSaveUserSession>(_onLoginSaveUserSession);

  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEvent (InitEvent event, Emitter<LoginState> emit) async{
    AuthResponse? authResponse = await authusecases.getUserSession.run();
    print('INICIO DE SESION: ${authResponse?.toJson()}');
    emit(state.copyWith(formKey: formKey));

    if(authResponse != null ){
          emit(
            state.copyWith(
              response: Success(authResponse),//Authresponse -> User y data
              formKey: formKey
              ),
          );
    }
  }

  Future<void> _onLoginSaveUserSession (LoginSaveUserSession event, Emitter<LoginState> emit) async{
    await authusecases.saveUserSession.run(event.authResponse);
  }

  Future<void> _onLoginFormReset (LoginFormReset event, Emitter<LoginState> emit) async{
    state.formKey?.currentState?.reset();
  }

  Future<void> _onEmailChanged (EmailChanged event, Emitter<LoginState> emit) async{
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty ? null : "Ingresa el email"
          ),
        formKey: formKey
    ));
  }


  Future<void> _onPasswordChanged (PasswordChanged event, Emitter<LoginState> emit) async{
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: event.password.value.isNotEmpty && event.password.value.length >= 6  ? null : "Ingesa el password"
          ),
          
        formKey: formKey
    ));
  }

  Future<void> _onLoginSubmit(LoginSubmit event, Emitter<LoginState> emit) async {
  emit(
    state.copyWith(
      response: Loading(),
      formKey: formKey,
    ),
  );

  try {
    Resource response = await authusecases.login.run(state.email.value, state.password.value);
    
    emit(
      state.copyWith(
        response: response,
        formKey: formKey,
      ),
    );

  } catch (e) {
    emit(
      state.copyWith(
        response: Error('Error inesperado: ${e.toString()}'), // Mensaje de error
        formKey: formKey,
      ),
    );
  }
}
 
}