// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/sys/dio.dart' as _i987;
import '../core/sys/environment.dart' as _i688;
import '../features/index/data/data_source/test.dart' as _i277;

const String _staging = 'staging';
const String _development = 'development';
const String _production = 'production';

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i987.DioBase>(() => _i987.DioBaseImpl());
  gh.singleton<_i688.StagingEnvironment>(
    () => _i688.StagingEnvironment(),
    registerFor: {_staging},
  );
  gh.singleton<_i688.DevEnvironment>(
    () => _i688.DevEnvironment(),
    registerFor: {_development},
  );
  gh.factory<_i277.ApiService>(() => _i277.ApiService(gh<_i526.Environment>()));
  gh.singleton<_i688.ProdEnvironment>(
    () => _i688.ProdEnvironment(),
    registerFor: {_production},
  );
  return getIt;
}
