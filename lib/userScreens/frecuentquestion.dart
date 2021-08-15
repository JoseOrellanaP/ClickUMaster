import 'package:flutter/material.dart';

class clickUFrequentQ extends StatefulWidget {
  @override
  _clickUFrequentQState createState() => _clickUFrequentQState();
}

class _clickUFrequentQState extends State<clickUFrequentQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Preguntas Frecuentes"
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Preguntas frecuentes",
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
