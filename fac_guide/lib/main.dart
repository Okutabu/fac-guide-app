import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fac_guide/chatgpt/view/chatgpt_page.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'mapProvider.dart';

import 'search_model.dart';
import 'mymap.dart';
import 'searchbar.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MapControllerProvider()),
        // Add other providers if needed
      ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapControllerProvider(),
      child: MaterialApp(
      title: 'Sur Le Campus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        iconTheme: const IconThemeData(
          color: Color(0xFF4d4d4d),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 4,
        ),
      ),
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: ChangeNotifierProvider<SearchModel>(
          create: (_) => SearchModel(),
          child: const MyHomePage(),
        ),
      ),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, title = 'Page d\'accueil'});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // controllers
  final FloatingSearchBarController _barController =
      FloatingSearchBarController();

  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = min(value, 2);
    _index == 2 ? _barController.hide() : _barController.show();
    setState(() {});
  }

  @override
  void dispose() {
    _barController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }


  Widget buildFloatingSearchBar() {
    return MyFloatingSearchBar(controller: _barController);
  }

  Future<Widget> buildMap() async {

  return InteractiveMap();
  
  }


  @override
  Widget build(BuildContext context) {
    final mapControllerProvider = Provider.of<MapControllerProvider>(context);
    final mapController = mapControllerProvider.mapController;
  return Scaffold(
    body: FutureBuilder<Widget>(
      future: buildMap(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Use the map widget returned from the buildMap function
          final mapWidget = snapshot.data;
          return Stack(
            children: [
              if (mapWidget != null) mapWidget,
              buildFloatingSearchBar(),
              // Floating Action Button
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatGptPage.create(),
                    ),
                  );
                  },
                  child: Icon(Icons.chat_bubble),
                ),
              ),
            ],
          );
        }
      },
    ),
  );;
}


  
}