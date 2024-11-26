
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/env.dart';

void main() => yourInit();

Future yourInit() async {
  // @override
  // final String appName = dotenv.env['APP_NAME']!;
  // @override
  // final String baseUrl =  dotenv.env['BASE_URL']!; //prod primary server
  // @override
  // final Color primarySwatch = Colors.black;
  // @override
  // final EnvType environmentType = EnvType.production;

  await dotenv.load(fileName: '.env');
  return Env();
}
