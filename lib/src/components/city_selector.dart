
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

typedef OnChanged = void Function(String value);

class CitySelector extends StatefulWidget {
  final OnChanged onChanged;

  const CitySelector({
    Key? key,
    required this.onChanged
  }) : super(key: key);

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  List<String> princesList = [];

  @override
  void initState() {
    super.initState();

    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonData = await rootBundle.loadString('assets/data/city.json');
    print("jsonData: $jsonData");
    List<dynamic> jsonMap = jsonDecode(jsonData);

    List<String> allCity = jsonMap.map((e) => e.toString()).toList();

    print("jsonMap: $jsonMap");


    // Print the first country and its children
    setState(() {
      princesList =  allCity;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
      ),
      height: 600,
      // child: AlphabeticalIndexPosition(data: princesList, onChanged: widget.onChanged,),
      child: Container(),

    );
  }
}
