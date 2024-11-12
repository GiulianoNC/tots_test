import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/login/LoginPage.dart';
import 'package:tots_test/src/presentation/pages/register/RegisterContent.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterBloc.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterState.dart';
import 'package:tots_test/src/presentation/widgets/Image_background.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc? _bloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 


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
              if (responseState is Success) {
                Fluttertoast.showToast(
                  msg: 'Successful registration',
                  toastLength: Toast.LENGTH_SHORT,
                );     
                  Navigator.pop(context);      
              } else if (responseState is Error) {
                Fluttertoast.showToast(
                  msg: responseState.message,
                  toastLength: Toast.LENGTH_SHORT,
                );          
              }else if((responseState is Loading)){
                  Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Registercontent(_bloc, state,_formKey);
                }
              },
            ),
          ),

          ]
        ),
    );
  }
}
