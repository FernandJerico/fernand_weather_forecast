import 'dart:convert';

class GetWeatherResponseModel {
  final Data? data;
  final Location? location;

  GetWeatherResponseModel({
    this.data,
    this.location,
  });

  factory GetWeatherResponseModel.fromJson(String str) =>
      GetWeatherResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetWeatherResponseModel.fromMap(Map<String, dynamic> json) =>
      GetWeatherResponseModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        location: json["location"] == null
            ? null
            : Location.fromMap(json["location"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "location": location?.toMap(),
      };
}

class Data {
  final DateTime? time;
  final Map<String, double?>? values;

  Data({
    this.time,
    this.values,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        values: Map.from(json["values"]!)
            .map((k, v) => MapEntry<String, double?>(k, v?.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "time": time?.toIso8601String(),
        "values":
            Map.from(values!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Location {
  final double? lat;
  final double? lon;
  final String? name;
  final String? type;

  Location({
    this.lat,
    this.lon,
    this.name,
    this.type,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lon": lon,
        "name": name,
        "type": type,
      };
}
