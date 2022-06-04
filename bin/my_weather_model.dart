import 'package:hive/hive.dart';
part 'my_weather_model.g.dart';

@HiveType(typeId: 0)
class MyWeatherModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? data;
  @HiveField(2)
  String? tempDay;
  @HiveField(3)
  String? tempNight;

  MyWeatherModel({this.title, this.data, this.tempDay, this.tempNight});

  MyWeatherModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    data = json['data'];
    tempDay = json['tempDay'];
    tempNight = json['tempNight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['data'] = data;
    map['tempDay'] = tempDay;
    map['tempNight'] = tempNight;
    return map;
  }

  @override
  String toString() {
    return """
    Весь день: $title, 
    Число: $data, 
    Днём:$tempDay, 
    Ночью: $tempNight""";
  }
}
