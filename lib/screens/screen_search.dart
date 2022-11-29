import 'package:flutter/material.dart';

class Screen_search extends StatefulWidget {
  const Screen_search({super.key});

  @override
  State<Screen_search> createState() => _Screen_searchState();
}

class _Screen_searchState extends State<Screen_search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 29, 28, 68),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: textform(),
          ),
        ),
      ),
    );
  }

  Widget textform() {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 20.0),
      autofocus: true,
      decoration: InputDecoration(
        focusColor: Colors.white,
        hintText: 'search', hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Color.fromARGB(255, 67, 123, 202),
        contentPadding: const EdgeInsets.all(22.0),
        //prefixIcon: const Icon(Icons.search),
      ),
      textAlign: TextAlign.center,
    );
  }
}
