import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/client/create/ClienCreateContent.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateBloc.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateEvent.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateState.dart';

class ClientCreatePage extends StatefulWidget {
  const ClientCreatePage({super.key});

  @override
  State<ClientCreatePage> createState() => _ClientCreatePageState();
}

class _ClientCreatePageState extends State<ClientCreatePage> {
  ClientCreateBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ClientCreateBloc>(context);
     _bloc?.add(ClientCreateInitEvent()); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocListener<ClientCreateBloc, ClientCreateState>(
            listener: (context, state) {
              final responseState = state.response;
              try {
                if (responseState is Success) {
                  _bloc?.add(ClientFormReset());
                  Fluttertoast.showToast(msg: "El cliente se creó correctamente", toastLength: Toast.LENGTH_LONG);
                  Navigator.pop(context); 
                } else if (responseState is Error) {
                  Fluttertoast.showToast(msg: responseState.message, toastLength: Toast.LENGTH_LONG);
                }
              } catch (e) {
                print('ERROR: $e');
                Fluttertoast.showToast(msg: "Hubo un error al procesar la solicitud.", toastLength: Toast.LENGTH_LONG);
              }
            },
            child: BlocBuilder<ClientCreateBloc, ClientCreateState>(
              builder: (context, state) {
                return ClientCreateContent(_bloc, state);
              },
            ),
          )
    );
  }
}