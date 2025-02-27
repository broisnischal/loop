// lib/core/sys/environment.dart
import 'package:injectable/injectable.dart';

enum Flavor {
  development, // Match your productFlavor names exactly
  staging,
  production
}

abstract class EnvironmentF {
  Flavor get flavor;
  String get apiUrl;
  String get apiKey;
}

// environment.dart
@Environment('development') // Use injectable's annotation
@singleton
class DevEnvironment implements EnvironmentF {
  @override
  Flavor get flavor => Flavor.development;
  @override
  String get apiUrl => 'http://localhost:3000/v1/api';
  @override
  String get apiKey => 'dev_key';
}

@Environment('staging')
@singleton
class StagingEnvironment implements EnvironmentF {
  @override
  Flavor get flavor => Flavor.staging;
  @override
  String get apiUrl => 'https://loop.snehaa.store/v1/api';
  @override
  String get apiKey => 'staging_key';
}

@Environment('production')
@singleton
class ProdEnvironment implements EnvironmentF {
  @override
  Flavor get flavor => Flavor.production;
  @override
  String get apiUrl => 'https://prod.api.com';
  @override
  String get apiKey => 'prod_key';
}
