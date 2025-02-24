import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loop/core/sys/environment.dart';

abstract class DioBase {
  @lazySingleton
  Dio dio(EnvironmentF env) => Dio(
        BaseOptions(
          baseUrl: env.apiUrl, //Do it for flavoring
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
}

@Injectable(as: DioBase)
class DioBaseImpl extends DioBase {}
