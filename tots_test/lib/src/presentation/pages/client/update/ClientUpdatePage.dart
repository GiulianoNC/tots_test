import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientBloc.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientEvent.dart';
import 'package:tots_test/src/presentation/pages/client/update/ClientUpdateContent.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateBloc.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateEvent.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateState.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({super.key});

  @override
  State<ClientUpdatePage> createState() => _AdminCategoryUpdatePageState();
}

class _AdminCategoryUpdatePageState extends State<ClientUpdatePage> {

  Client? client;
  ClientUpdateBloc? _bloc;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      print('Disparando ClientUpdateInitEvent con client: $client');
      _bloc?.add(ClientUpdateInitEvent(client: client));
    });
  }

  @override
  void dispose() {//se ejecuta cuando cerramos la pantalla, pare visualizar los cambios que se efectuen
    super.dispose();
    _bloc?.add(ResetForm());
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientUpdateBloc>(context);
    client = ModalRoute.of(context)?.settings.arguments as Client;
    return Scaffold(
      body:BlocListener<ClientUpdateBloc,ClientUpdateState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            context.read<ClientBloc>().add(FetchClients(1));//una vez que es exitoso, traiga los cambios haciendo un refresh
            Fluttertoast.showToast(msg: "El cliente se actualizó correctamente", toastLength: Toast.LENGTH_LONG);
            Navigator.pop(context); 
          }else if(responseState is Error){
            Fluttertoast.showToast(msg: responseState.message, toastLength: Toast.LENGTH_LONG);
          }          
        },
          child: BlocBuilder<ClientUpdateBloc,ClientUpdateState>(
            builder: (context,state) {
              return ClientUpdateContent(_bloc, state,client!);
            }
          ),
      )
    );
  }
}
