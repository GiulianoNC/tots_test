import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tots_test/injection.dart';
import 'package:tots_test/src/domain/usersCases/client/ClientUseCases.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientBloc.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateBloc.dart';
import 'package:tots_test/src/presentation/pages/client/create/bloc/ClientCreateEvent.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateBloc.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginBloc.dart';
import 'package:tots_test/src/presentation/pages/login/bloc/LoginEvent.dart';
import 'package:tots_test/src/domain/usersCases/auth/AuthUseCases.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterBloc.dart';
import 'package:tots_test/src/presentation/pages/register/bloc/RegisterEvent.dart';

List<BlocProvider> blocProviders=[
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator<Authusecases>())..add(InitEvent())),
  BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(locator<Authusecases>())..add(RegisterInitEvent())),
  BlocProvider<ClientBloc>(create: (context) => ClientBloc(locator<ClientUsesCases>(),locator<Authusecases>())),
  BlocProvider<ClientCreateBloc>(create: (context) => ClientCreateBloc(locator<ClientUsesCases>())..add(ClientCreateInitEvent())),
  BlocProvider<ClientUpdateBloc>(create: (context) => ClientUpdateBloc(locator<ClientUsesCases>())),

];