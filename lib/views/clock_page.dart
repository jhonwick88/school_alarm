import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(onPressed: () {}, child: Text("YES TEKAN INI")));
  }
}
