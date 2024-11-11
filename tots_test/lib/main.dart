import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/injection.dart';
import 'package:tots_test/src/BlocProviders.dart';
import 'package:tots_test/src/presentation/pages/client/List/ClientPage.dart';
import 'package:tots_test/src/presentation/pages/client/create/ClientCreatePage.dart';
import 'package:tots_test/src/presentation/pages/client/update/ClientUpdatePage.dart';
import 'package:tots_test/src/presentation/pages/login/LoginPage.dart';
import 'package:tots_test/src/presentation/pages/register/RegisterPage.dart';


void main() async{
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: 'login',
        routes:{
          'login':(BuildContext context)=> Loginpage(),
          'register':(BuildContext context)=> RegisterPage(),
          'clienpage':(BuildContext context)=> ClientPage(),
          'clienpage/create':(BuildContext context)=> ClientCreatePage(),
          'client/update':(BuildContext context)=> ClientUpdatePage(),
          
        }     
      ),            
    );
  }
}


