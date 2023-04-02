// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:router/router.module.dart' as _i3;

import '../../app/alert/logic/alert_cubit.dart' as _i4;
import '../../app/app_root/services/app_root_service.dart' as _i6;
import '../../app/auth/__.dart' as _i7;
import '../../app/auth/logic/auth/auth_cubit.dart' as _i8;
import '../../app/auth/services/auth_service.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i3.RouterPackageModule().init(gh);
    gh.lazySingleton<_i4.AlertCubit>(
      () => _i4.AlertCubit(),
      dispose: (i) => i.close(),
    );
    gh.lazySingleton<_i5.AuthService>(() => _i5.AuthService());
    gh.lazySingleton<_i6.AppRootService>(
        () => _i6.AppRootService(gh<_i7.AuthService>()));
    gh.lazySingleton<_i8.AuthCubit>(() => _i8.AuthCubit(gh<_i5.AuthService>()));
    return this;
  }
}
