import 'package:flutter/material.dart';
import 'package:work_with_provider/widgets/example_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExampleWidget(),
    );
  }
}