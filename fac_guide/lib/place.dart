import 'dart:core';

class Place {
  const Place({
    required this.numero,
    required this.nom,
    this.entree = const [],
    this.description = '',
    this.image = '',
  });

  factory Place.fromJson(Map<String, dynamic> map) {
    var myentries = map['entree'];
    return Place(
      numero: map['numero'] ?? "",
      nom: map['name'] ?? "",
      entree: [
        {
          "id": 1,
          "latitude": myentries['latitude'],
          "longitude": myentries['longitude']
        }
      ],
      description: map['description'] ?? "",
      image: map['image'] ?? "",
    );
  }

  final String numero;
  final String nom;
  final List<Map<String, dynamic>> entree;
  final String description;
  final String image;

  @override
  String toString() =>
      'Place(numero: $numero, nom: $nom, entree: $entree, description: $description, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Place &&
        other.numero == numero &&
        other.nom == nom &&
        other.description == description &&
        other.image == image;
  }

   List<Map<String, dynamic>> newEntree(longitude, latitude){
    List<Map<String, dynamic>> newEntree = [];
    for (var i = 0; i < entree.length; i++) {
      newEntree.add({
        "id": i,
        "latitude": latitude,
        "longitude": longitude
      });
    }
    return newEntree;
   }

  @override
  int get hashCode =>
      numero.hashCode ^ nom.hashCode ^ entree.hashCode ^ description.hashCode ^ image.hashCode;
}
