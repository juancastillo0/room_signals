enum AppEnvironment {
  production,
  development;

  bool get isProduction => this == AppEnvironment.production;
  bool get isDevelopment => this == AppEnvironment.development;
}
