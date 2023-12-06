
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapControllerProvider extends ChangeNotifier {
  MapController _mapController = MapController.withPosition(initPosition: GeoPoint(latitude: 45.641285, longitude: 5.869833));

  MapController get mapController => _mapController;

  void moveToPoint(GeoPoint point) {
    _mapController.changeLocation(point);
    notifyListeners();
  }
}
