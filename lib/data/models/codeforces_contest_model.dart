// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<CodeforcesModel> codeforcesModelFromJson(String str) =>
    List<CodeforcesModel>.from(json.decode(str).map((x) => CodeforcesModel.fromJson(x)));

String codeforcesModelToJson(List<CodeforcesModel> data) =>
    json.encode(List<CodeforcesModel>.from(data.map((x) => x.toJson())));

class CodeforcesModel {
  CodeforcesModel({
    required this.name,
    required this.url,
    required this.startTime,
    required this.endTime,
    required this.duration,

    required this.in24Hours,
    required this.status,
  });

  String name;
  String url;
  String startTime;
  String endTime;
  String duration;

  In24Hours in24Hours;
  Status status;

  factory CodeforcesModel.fromJson(Map<String, dynamic> json) => CodeforcesModel(
    name: json["name"],
    url: json["url"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    duration: json["duration"],

    in24Hours: in24HoursValues.map[json["in_24_hours"]]!,
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
    "start_time": startTime,
    "end_time": endTime,
    "duration": duration,

    "in_24_hours": in24HoursValues.reverse[in24Hours],
    "status": statusValues.reverse[status],
  };
}

enum In24Hours { NO, YES }

final in24HoursValues = EnumValues({"No": In24Hours.NO, "Yes": In24Hours.YES});

enum Status { CODING, BEFORE }

final statusValues =
EnumValues({"BEFORE": Status.BEFORE, "CODING": Status.CODING});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
