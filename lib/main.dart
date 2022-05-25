import 'package:ciwalk/firebase_options.dart';
import 'package:ciwalk/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await initHiveForFlutter();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kDebugMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://efacc0e4c19e43aca0c415df565f4627@o1258295.ingest.sentry.io/6432268';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(App()),
    );
  } else {
    runApp(App());
  }
}
