import 'package:flutter/material.dart';

class PageSatu extends StatefulWidget {
  const PageSatu({Key? key}) : super(key: key);

  @override
  _PageSatuState createState() => _PageSatuState();
}

class _PageSatuState extends State<PageSatu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Text("Yes Ibi kabarku"),
    );
  }
}
