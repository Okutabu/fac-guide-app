import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'mock_api_geopoint.dart';
import 'drawer.dart';
import 'mapProvider.dart';
import 'package:provider/provider.dart';

class InteractiveMap extends StatefulWidget {
  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  
  List<StaticPositionGeoPoint> _dynamicPoints = [];
  final MockBuildingsApi buildingsApi = MockBuildingsApi();
  late Future<List<StaticPositionGeoPoint>> dynamicPoints;

  @override
  void initState() {
    super.initState();
    // Fetch dynamic points from the API
    _loadDynamicPoints();
  }

  Future<void> _loadDynamicPoints() async {
    try {
      final dynamicPoints = await buildingsApi.getAllBuildingsAsGeoPoints();
      setState(() {
        _dynamicPoints = dynamicPoints;
      });
    } catch (e) {
      // Handle errors (e.g., show an error message)
      print('Error fetching dynamic points: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapControllerProvider = Provider.of<MapControllerProvider>(context);
    final mapController = mapControllerProvider.mapController;
    return OSMFlutter(
      osmOption: OSMOption(
        zoomOption: const ZoomOption(
          minZoomLevel: 18,
          maxZoomLevel: 19,
          stepZoom: 1,
        ),
        userLocationMarker: UserLocationMaker(
            personMarker: MarkerIcon(
              iconWidget: SizedBox(
                width: 32,
                height: 64,
                child: Image.asset(
                  "asset/directionIcon.png",
                  scale: .3,
                ),
              ),
            ),
            directionArrowMarker: MarkerIcon(
              // icon: Icon(
              //   Icons.navigation_rounded,
              //   size: 48,
              // ),
              iconWidget: SizedBox(
                width: 32,
                height: 64,
                child: Image.asset(
                  "asset/directionIcon.png",
                  scale: .3,
                ),
              ),
            ),
            ),
        staticPoints: _dynamicPoints,
        markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.place,
              color: Colors.blue,
              size: 56,
            ),
          ),
        ),
      ),
      mapIsLoading: _dynamicPoints.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Map is Loading.."),
                ],
              ),
            )
          : null, // Set to null when the map is not loading
      controller: mapController,
      onGeoPointClicked: (geoPoint) async{
        try {
          final data = await buildingsApi.getBuildingDetails(geoPoint.longitude, geoPoint.latitude);
          showBottomSheet(
            context: context,
            builder: (context) => DetailsDrawer(data),
          );
        } catch (e) {
          // Handle error
          print('Error: $e');
        }

      },
    );
  }
}
