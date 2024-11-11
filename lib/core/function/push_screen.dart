import 'package:flutter/cupertino.dart';

Future<void> pushScreen({
  required BuildContext context,
  required Widget screen,
}) async {
  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => screen,
    ),
  );
}

Future<void> pushAndRemoveUntil({
  required BuildContext context,
  required Widget screen,
}) async {
  Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute(
      builder: (context) => screen,
    ),
    (Route<dynamic> route) =>
        false, // This predicate removes all the previous routes
  );
}
