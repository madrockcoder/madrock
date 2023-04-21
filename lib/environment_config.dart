enum Flavor { dev, live }

class EnvironmentConfig {
  static final EnvironmentConfig _instance = EnvironmentConfig._internal();
  static Flavor? _appFlavor;

  factory EnvironmentConfig._internal() => _instance;

  static Flavor? get env {
    return _appFlavor;
  }

  static set flavor(Flavor environment) => _appFlavor = environment;
}
