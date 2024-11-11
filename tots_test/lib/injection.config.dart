// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tots_test/src/data/dataSource/local/SharedPref.dart' as _i905;
import 'package:tots_test/src/data/dataSource/remote/services/AuthService.dart'
    as _i782;
import 'package:tots_test/src/data/dataSource/remote/services/ClientService.dart'
    as _i78;
import 'package:tots_test/src/di/AppModule.dart' as _i231;
import 'package:tots_test/src/domain/repository/AuthRepository.dart' as _i494;
import 'package:tots_test/src/domain/repository/ClientRepository.dart' as _i436;
import 'package:tots_test/src/domain/usersCases/auth/AuthUseCases.dart'
    as _i1017;
import 'package:tots_test/src/domain/usersCases/client/ClientUseCases.dart'
    as _i851;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appmodule = _$Appmodule();
    gh.factory<_i905.SharedPref>(() => appmodule.sharedPred);
    gh.factoryAsync<String>(() => appmodule.token);
    gh.factory<_i782.Authservice>(() => appmodule.authservice);
    gh.factory<_i494.AuthRepository>(() => appmodule.authRepository);
    gh.factory<_i1017.Authusecases>(() => appmodule.authusecases);
    gh.factory<_i78.ClientService>(() => appmodule.clientService);
    gh.factory<_i436.ClientRepository>(() => appmodule.clientRepository);
    gh.factory<_i851.ClientUsesCases>(() => appmodule.clientUsesCases);
    return this;
  }
}

class _$Appmodule extends _i231.Appmodule {}
