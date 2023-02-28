import 'package:flutter/material.dart';

class ImageCarousleScreen extends StatefulWidget {
  const ImageCarousleScreen({Key? key}) : super(key: key);

  @override
  State<ImageCarousleScreen> createState() => _ImageCarousleScreenState();
}

class _ImageCarousleScreenState extends State<ImageCarousleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Image Screen'),
      ),
    );
  }
}
