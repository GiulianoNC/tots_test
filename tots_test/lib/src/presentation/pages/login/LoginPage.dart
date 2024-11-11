import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/domain/models/AuthResponse.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/login/LoginContent.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginBloc.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginEvent.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginState.dart';
import 'package:tots_test/src/presentation/widgets/Image_background.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  LoginBloc? _bloc;

  @override
  Widget build(BuildContext context) {

    _bloc = BlocProvider.of<LoginBloc>(context);

    return  Scaffold(
      body: Stack(
        children: [
        ImageBackground(),
         BlocListener<LoginBloc,LoginState>(
          listener: (context, state){
            final responseState = state.response;
            if (responseState is Error) {
              final errorMessage = responseState.message ?? 'Error desconocido';
              Fluttertoast.showToast(
                  msg: errorMessage,
                  toastLength: Toast.LENGTH_LONG,
              );
            }
            else if(responseState is Success){
              final authResponse = responseState.data as AuthResponse;
              _bloc?.add(LoginSaveUserSession(authResponse: authResponse));//guardar el usuario en caso de que la respuesta sea exitosa
              Fluttertoast.showToast(
                  msg: 'Exito',
                  toastLength: Toast.LENGTH_LONG,
              );
              Navigator.pushReplacementNamed(context, 'clienpage');
            }
          },
          child: BlocBuilder<LoginBloc,LoginState>(
            builder: (context, state){
              final responseState = state.response;
              if(responseState is Loading){
                return Stack(
                  children: [
                    Logincontent(_bloc, state),
                    Center(child: CircularProgressIndicator())
                  ],
                );
              }
              return Logincontent(_bloc, state);
            }
          ),
        ),
 
        ]
      )
    );
  }

}