import 'package:flutter/material.dart';

import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';
import '../res/string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.home,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
