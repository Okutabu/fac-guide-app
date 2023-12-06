import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsDrawer extends StatelessWidget {
  final Map<String, dynamic>? data;
  final int drawerWidth = 300;

  DetailsDrawer(this.data);

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width; // Set your custom drawer width
    double drawerHeight = MediaQuery.of(context).size.height * 0.5; // Set your custom drawer height

    return SizedBox(
      width: drawerWidth,
      height: drawerHeight,
      child: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor, // Use your app's primary color
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text('A propos'),
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'Details'),
                    Tab(text: 'Caractériques'),
                  ],
                ),
              ),
              body: TabBarView(
  children: [
    // Display your information for Tab 1
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200.0, // Set a suitable height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://www.bproperty.com/blog/wp-content/uploads/appartment-building-appartments-architecture-87223-1-1.jpg',
                    fit: BoxFit.cover,
                    width: 200.0, // Set a suitable width
                  ),
                );
              },
            ),
          ),
          Text(data?['number'] + " " + data?['name']),
        ],
      ),
    ),
      Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          Icon(Icons.computer, size: 24),
          SizedBox(width: 10),
          Text(
            'Salles informatiques: ' + (data?['Info'] ? 'Oui' : 'Non'),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Icon(Icons.wc, size: 24), // Icon for toilets
          SizedBox(width: 10),
          Text(
            'Toilettes: ' + (data?['Toilettes'] ? 'Oui' : 'Non'),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ],
  ),),
  ],
),

            ),
          ),
        ),
      ),
    );
  }
}