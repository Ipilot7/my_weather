import 'package:hive/hive.dart';
import 'data_weather.dart';
import 'my_weather_model.dart';

void main(List<String> arguments) {
  Hive.init('db');
  Hive.registerAdapter<MyWeatherModel>(MyWeatherModelAdapter());
  Data().runapp();
}