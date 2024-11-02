import 'package:todo/todo_app.dart';
import 'package:todo/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupServicesLocator();
  runApp(TodoApp());
}
