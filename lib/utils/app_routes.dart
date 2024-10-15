import 'package:contact_app/screen/backup/view/backup_screen.dart';
import 'package:contact_app/screen/contact/view/contact_screen.dart';
import 'package:contact_app/screen/home/view/home_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> app_route = {
  "/": (context) => HomeScreen(),
  "/contact": (context) => ContactScreen(),
  "/backup": (context) => BackupScreen(),
};