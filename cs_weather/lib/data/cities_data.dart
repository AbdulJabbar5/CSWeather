class CitiesData {

  // parameters
  String? city;
  String? admin;
  String? country;
  String? lat;
  String? lng;
  bool? isFavourite;

  CitiesData({this.city, this.admin, this.country, this.lat, this.lng});

  CitiesData.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    admin = json['admin'];
    country = json['country'];
    lat = json['lat'];
    lng = json['lng'];
  }

  static List<CitiesData> fromJsonToList(List<dynamic> list) {
    final weathers = <CitiesData>[];
    for (int i = 0; i < list.length; i++) {
      weathers.add(
        CitiesData.fromJson(list[i]),
      );
    }
    return weathers;
  }
}