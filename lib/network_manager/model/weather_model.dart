import 'dart:convert';

//MODEL DATA
Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Current current;
  Hourly hourly;
  Daily daily;

  Welcome({
    required this.current,
    required this.hourly,
    required this.daily
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    current: Current.fromJson(json["current"]),
    hourly: Hourly.fromJson(json["hourly"]),
    daily: Daily.fromJson(json['daily']),
  );

  Map<String, dynamic> toJson() => {
    "current": current.toJson(),
    "hourly": hourly.toJson(),
    'daily': daily.toJson(),
  };
}

class Current {
  String time;
  double temperature2M;
  double windSpeed10M;

  Current({
    required this.time,
    required this.temperature2M,
    required this.windSpeed10M,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    time: json["time"],
    temperature2M: json["temperature_2m"]?.toDouble(),
    windSpeed10M: json["wind_speed_10m"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "temperature_2m": temperature2M,
    "wind_speed_10m": windSpeed10M,
  };
}

class Hourly {
  List<String> time;
  List<double> windSpeed10M;
  List<double> temperature2M;
  List<int> relativeHumidity2M;

  Hourly({
    required this.time,
    required this.windSpeed10M,
    required this.temperature2M,
    required this.relativeHumidity2M,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    time: List<String>.from(json["time"].map((x) => x)),
    windSpeed10M: List<double>.from(json["wind_speed_10m"].map((x) => x?.toDouble())),
    temperature2M: List<double>.from(json["temperature_2m"].map((x) => x?.toDouble())),
    relativeHumidity2M: List<int>.from(json["relative_humidity_2m"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "time": List<dynamic>.from(time.map((x) => x)),
    "wind_speed_10m": List<dynamic>.from(windSpeed10M.map((x) => x)),
    "temperature_2m": List<dynamic>.from(temperature2M.map((x) => x)),
    "relative_humidity_2m": List<dynamic>.from(relativeHumidity2M.map((x) => x)),
  };
}

class Daily {
  List<DailyData> data;
  Daily({required this.data});

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
      data:
      List<DailyData>.from(json['daily'].map((x) => DailyData.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    'daily': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DailyData {
  String time;
  double temperature2M;
  double windSpeed10M;
  int relativeHumidity2M;
  
  DailyData({
    required this.time,
    required this.temperature2M,
    required this.windSpeed10M,
    required this.relativeHumidity2M,
});
  
  factory DailyData.fromJson(Map<String, dynamic> json) => DailyData(
      time: json['time'],
      temperature2M: json['temperature_2m'].toDouble(),
      windSpeed10M: json['windSpeed_10m'].toDouble(),
      relativeHumidity2M: json['relative_humidity_2m']);
  
  Map<String, dynamic> toJson() => {
    'time': time,
    'temperature_2m': temperature2M,
    'windSpeed_10m': windSpeed10M,
    'relative_humidity_2m': relativeHumidity2M,
  };
}
