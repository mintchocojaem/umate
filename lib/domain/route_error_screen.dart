import 'package:flutter/material.dart';

class RouteErrorScreen extends StatelessWidget {

  final String errorMessage;

  const RouteErrorScreen({super.key, this.errorMessage = 'Page not found!'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}