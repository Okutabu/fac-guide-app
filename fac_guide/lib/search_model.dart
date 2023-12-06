import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'mock_api_geopoint.dart';
import 'place.dart';

class SearchModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final MockBuildingsApi buildingsApi = MockBuildingsApi();

  List<Place> _suggestions = history;
  List<Place> get suggestions => _suggestions;

  String _query = '';
  String get query => _query;

  Future<void> onQueryChanged(String query) async {
    if (query == _query) {
      return;
    }

    _query = query;
    _isLoading = true;
    notifyListeners();

    if (query.isEmpty) {
      _suggestions = history;
    } else {
      final body = await buildingsApi.getBuildingsByName(query);

      _suggestions = body
          .map((dynamic e) => Place.fromJson(e as Map<String, dynamic>))
          .toSet()
          .toList();
    }
    
    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _suggestions = history;
    notifyListeners();
  }
}

const List<Place> history = <Place>[
  Place(
    numero: "8A",
    nom: "Service logistique de site",
    entree: [
      {"id": 1, "latitude": 45.642061, "longitude": 5.868208}
    ],
    description: "",
    image: "",
  ),
  Place(
    numero: "8B",
    nom: "Belledonne",
    entree: [
      {"id": 1, "latitude": 45.641844, "longitude": 5.868502},
      {"id": 2, "latitude": 45.641927, "longitude": 5.868758},
      {"id": 3, "latitude": 45.642020, "longitude": 5.869228},
      {"id": 4, "latitude": 45.642153, "longitude": 5.869884},
      {"id": 5, "latitude": 45.642258, "longitude": 5.870368}
    ],
    description: "",
    image: "",
  ),
  Place(
    numero: "8D",
    nom: "Iseran",
    entree: [
      {"id": 1, "latitude": 45.641995, "longitude": 5.869231},
      {"id": 2, "latitude": 45.641713, "longitude": 5.869369},
      {"id": 3, "latitude": 45.641908, "longitude": 5.869640},
    ],
    description: "",
    image: "",
  ),
];
