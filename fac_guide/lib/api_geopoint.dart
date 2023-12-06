import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter/material.dart';

class BuildingsApi {
  final String apiUrl;

  BuildingsApi(this.apiUrl);

  Future<List<StaticPositionGeoPoint>> getAllBuildingsAsGeoPoints() async {
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> buildings = json.decode(response.body)["batiments"];

      final List<StaticPositionGeoPoint> geoPoints = buildings.map((building) {
        final String name = building["nom"];
        final List<dynamic> entryPoints = building["entree"] ?? [];
        final List<GeoPoint> geoPoints = entryPoints
            .map((entry) => GeoPoint(
                  latitude: entry["latitude"],
                  longitude: entry["longitude"],
                ))
            .toList();

        return StaticPositionGeoPoint(
          name,
          const MarkerIcon(
            icon: Icon(
              Icons.place,
              color: Colors.blue,
              size: 32,
            ),
          ),
          geoPoints,
        );
      }).toList();

      return geoPoints;
    } else {
      throw Exception('Failed to load buildings');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}


  Future<Map<String, dynamic>?> getBuildingByName(String buildingName) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> buildings = json.decode(response.body)["batiments"];
      final building = buildings.firstWhere(
        (b) => b["nom"] == buildingName,
        orElse: () => null,
      );

      if (building != null) {
        return {
          "name": building["nom"],
          "position": building["entree"] ?? [],
        };
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load buildings');
    }
  }
}


