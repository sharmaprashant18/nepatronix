import 'package:flutter/material.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Subscription Screen'),
      ),
      body: Center(
        child: Text('Subscription Screen'),
      ),
    );
  }
}
