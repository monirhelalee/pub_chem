import 'package:logging/logging.dart';
import 'package:pub_chem/app/config/service_locator.dart';

enum EnvType { development, staging, production }

class Env {
  Env() {
    value = this;
  }

  late String baseUrl;
  static late Env value;
  EnvType environmentType = EnvType.development;
  Level logLevel = Level.OFF;

  Future<void> init() async {
    await setupServiceLocator();
    await sl.allReady();
  }
}

class Staging extends Env {
  Staging() {
    baseUrl = 'https://pubchem.ncbi.nlm.nih.gov/rest/pug/';
    environmentType = EnvType.staging;
    logLevel = Level.ALL;
  }
}

class Production extends Env {
  Production() {
    baseUrl = 'https://pubchem.ncbi.nlm.nih.gov/rest/pug/';
    environmentType = EnvType.production;
    logLevel = Level.OFF;
  }
}

class Development extends Env {
  Development() {
    baseUrl = 'https://pubchem.ncbi.nlm.nih.gov/rest/pug/';
    environmentType = EnvType.development;
    logLevel = Level.ALL;
  }
}
