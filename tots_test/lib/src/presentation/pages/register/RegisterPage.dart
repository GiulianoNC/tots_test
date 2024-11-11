import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/register/RegisterContent.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterBloc.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterEvent.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterState.dart';
import 'package:tots_test/src/presentation/widgets/Image_background.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc? _bloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<RegisterBloc>(context, listen: false);
    return Scaffold(
      body: 
        Stack(
          children: [
           ImageBackground(),  
           BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              final responseState = state.response;
              if (responseState is Error) {
                Fluttertoast.showToast(
                  msg: responseState.message,
                  toastLength: Toast.LENGTH_LONG,
                );
              } else if (responseState is Success) {
                _bloc?.add(RegisterFormReset());
                Fluttertoast.showToast(
                  msg: 'Registro exitoso',
                  toastLength: Toast.LENGTH_LONG,
                );
              }
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                if (state is Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Registercontent(_bloc, state);
                }
              },
            ),
          ),

          ]
        ),
    );
  }
}
