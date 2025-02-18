import 'package:injectable/injectable.dart';

abstract class EnvConfig {
  String get baseUrl;
}

@Injectable(as: EnvConfig)
@prod
class ProdConfig implements EnvConfig {
  @override
  String get baseUrl => 'https://api.production.com';
}

@Injectable(as: EnvConfig)
@dev
class DevConfig implements EnvConfig {
  @override
  String get baseUrl => 'https://api.development.com';
}

@Injectable(as: EnvConfig)
@test
class TestConfig implements EnvConfig {
  @override
  String get baseUrl => 'https://api.test.com';
}
