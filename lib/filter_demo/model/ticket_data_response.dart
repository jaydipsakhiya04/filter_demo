import 'dart:convert';

List<TicketDataResponse> ticketDataResponseFromJson(String str) => List<TicketDataResponse>.from(json.decode(str).map((x) => TicketDataResponse.fromJson(x)));


class TicketDataResponse {
  int id;
  String companyName;
  ClassType classType;
  String startTime;
  String endTime;
  String startingDate;
  String destinationDate;
  int remainingDays;
  String duration;
  int price;

  TicketDataResponse({
    required this.id,
    required this.companyName,
    required this.classType,
    required this.startTime,
    required this.endTime,
    required this.startingDate,
    required this.destinationDate,
    required this.remainingDays,
    required this.duration,
    required this.price,
  });

  factory TicketDataResponse.fromJson(Map<String, dynamic> json) => TicketDataResponse(
    id: json["id"],
    companyName: json["companyName"],
    classType: classTypeValues.map[json["classType"]]!,
    startTime: json["startTime"],
    endTime: json["endTime"],
    startingDate:json["startingDate"],
    destinationDate: json["destinationDate"],
    remainingDays: json["remainingDays"],
    duration: json["duration"],
    price: json["price"],
  );

}

enum ClassType {
  standard,
  vip,
  local
}

final classTypeValues = EnumValues({
  "Standard": ClassType.standard,
  "VIP": ClassType.vip
});

enum Duration {
  THE_1_H_10_M,
  THE_1_H_15_M,
  THE_1_H_20_M,
  THE_1_H_30_M
}

final durationValues = EnumValues({
  "1 h 10 m": Duration.THE_1_H_10_M,
  "1 h 15 m": Duration.THE_1_H_15_M,
  "1 h 20 m": Duration.THE_1_H_20_M,
  "1 h 30 m": Duration.THE_1_H_30_M
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
