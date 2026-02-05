import 'package:pub_chem/app/app.dart';
import 'package:pub_chem/app/config/env.dart';
import 'package:pub_chem/bootstrap.dart';

Future<void> main() async {
  await bootstrap(
    () => const App(),
    Production(),
  );
}
