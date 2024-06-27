import 'package:flutter/material.dart';

mixin MediaQueryMixin<T extends StatefulWidget> on State<T> {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  Orientation get orientation => MediaQuery.of(context).orientation;
  EdgeInsets get padding => MediaQuery.of(context).padding;
  EdgeInsets get viewInsets => MediaQuery.of(context).viewInsets;

  double get horizontalPadding => MediaQuery.of(context).padding.horizontal;
  double get verticalPadding => MediaQuery.of(context).padding.vertical;
}
