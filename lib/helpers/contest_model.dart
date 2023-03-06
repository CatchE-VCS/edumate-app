
import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<NewsModel>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    required this.name,
    required this.url,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.site,
    required this.in24Hours,
    required this.status,
  });

  String name;
  String url;
  String startTime;
  String endTime;
  String duration;
  String site;
  In24Hours in24Hours;
  Status status;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    name: json["name"],
    url: json["url"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    duration: json["duration"],
    site: json["site"],
    in24Hours: in24HoursValues.map[json["in_24_hours"]]!,
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
    "start_time": startTime,
    "end_time": endTime,
    "duration": duration,
    "site": site,
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
