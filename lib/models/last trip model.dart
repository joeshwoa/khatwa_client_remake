import 'dart:convert';

class Trip {
  LastTrip? lastTrip;

  Trip({
    this.lastTrip,
  });

  factory Trip.fromRawJson(String str) => Trip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    lastTrip: json["lastTrip"] == null ? null : LastTrip.fromJson(json["lastTrip"]),
  );

  Map<String, dynamic> toJson() => {
    "lastTrip": lastTrip?.toJson(),
  };
}

class LastTrip {
  Location? pickupLocation;
  String? id;
  String? passenger;
  String? driver;
  Location? destinationLocation;
  String? status;
  String? date;
  DateTime? dateMiliSeconds;
  int? fare;

  LastTrip({
    this.pickupLocation,
    this.id,
    this.passenger,
    this.driver,
    this.destinationLocation,
    this.status,
    this.date,
    this.dateMiliSeconds,
    this.fare,
  });

  factory LastTrip.fromRawJson(String str) => LastTrip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastTrip.fromJson(Map<String, dynamic> json) => LastTrip(
    pickupLocation: json["pickupLocation"] == null ? null : Location.fromJson(json["pickupLocation"]),
    id: json["_id"],
    passenger: json["passenger"],
    driver: json["driver"],
    destinationLocation: json["destinationLocation"] == null ? null : Location.fromJson(json["destinationLocation"]),
    status: json["status"],
    date: json["date"],
    dateMiliSeconds: json["dateMiliSeconds"] == null ? null : DateTime.parse(json["dateMiliSeconds"]),
    fare: json["fare"],
  );

  Map<String, dynamic> toJson() => {
    "pickupLocation": pickupLocation?.toJson(),
    "_id": id,
    "passenger": passenger,
    "driver": driver,
    "destinationLocation": destinationLocation?.toJson(),
    "status": status,
    "date": date,
    "dateMiliSeconds": dateMiliSeconds?.toIso8601String(),
    "fare": fare,
  };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
