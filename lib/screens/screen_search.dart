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
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(232, 26, 71, 148),
                Color.fromARGB(232, 21, 79, 161),
                Color.fromARGB(222, 4, 12, 67),
                Color.fromARGB(218, 6, 61, 138),
                Color.fromARGB(218, 5, 65, 148)
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: textform(),
          ),
        ),
      ),
    );
  }

  Widget textform() {
    return TextFormField(
      style: TextStyle(color: Colors.black, fontSize: 20.0),
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            // borderSide: BorderSide(width: 3, color: Colors.greenAccent),
            borderRadius: BorderRadius.circular(8.0)),
        focusColor: Colors.white,
        hintText: 'search',
        filled: true,
        fillColor: Color.fromARGB(255, 188, 219, 234),
        contentPadding: const EdgeInsets.all(22.0),
        //prefixIcon: const Icon(Icons.search),
      ),
      textAlign: TextAlign.center,
    );
  }
}
