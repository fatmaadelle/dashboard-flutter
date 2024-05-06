import 'package:flutter/material.dart';
import 'package:new_project/pages/dashBoard.dart';

void main() {
  runApp(StartPoint());
}
class StartPoint extends StatelessWidget {
  const StartPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashBoard(),

    );

  }
}


