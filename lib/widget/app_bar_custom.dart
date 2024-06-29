import 'package:cars/common/my_colors.dart';
import 'package:flutter/material.dart';

AppBar buildCustomAppBar({
  required BuildContext context,
  required String title,
  bool showBackButton = false,
  List<Widget>? actions,
  Color? backgroundColor,
  Color? iconColor,
  double? iconSize,
}) {
  return AppBar(
    title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
    centerTitle: true,
    leading: showBackButton
        ? Container(
            margin: const EdgeInsets.all(8),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: backgroundColor ?? MyColors.darkTextTheme,
                padding: const EdgeInsets.all(4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                size: iconSize ?? 28,
                color: iconColor ?? MyColors.drawerTheme,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        : null,
    backgroundColor: backgroundColor ?? MyColors.drawerTheme,
    actions: actions,
  );
}
