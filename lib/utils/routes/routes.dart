import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'routes_name.dart';
import '../../view/home_screen.dart';
import '../../view/detail_view.dart';
import '../../view/edit_view.dart';
import '../../res/string.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );

      case RoutesName.detail:
        return MaterialPageRoute(
          builder: (BuildContext context) => DetailView(
            petTags: [],
            petPhotoUrls: [],
          ),
        );

      case RoutesName.edit:
        return MaterialPageRoute(
          builder: (BuildContext context) => EditView(
            petTags: [],
            petPhotoUrls: [],
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text(
                Strings.NO_ROUTE,
              ),
            ),
          );
        });
    }
  }
}
