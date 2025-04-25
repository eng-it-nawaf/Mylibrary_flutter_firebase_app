import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    String? title,
    List<Widget>? actions,
  }) : super(
    title: title != null ? Text(title) : null,
    actions: actions,
    elevation: 4,
    centerTitle: true,
  );
}