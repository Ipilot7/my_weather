import 'dart:io';

import 'package:html/parser.dart' as parser;
import 'utils.dart';
import 'package:http/http.dart';
import 'input_data.dart';
import 'my_weather_model.dart';

//Выводим и сохраняем данные
class Data with Utils {
  List<MyWeatherModel> _listMyWeatherModel = [];
  List countrys = [];
  List regions = [];
  var inputDataModel = InputData();
  Future runapp() async {
    print("Добро пожаловать! Давайте обновим данные ...");
    print('Введите страну(ангийскими буквами): ');
    inputDataModel.country = stdin.readLineSync()!.toLowerCase();
    print('Введите город(ангийскими буквами): ');
    inputDataModel.region = stdin.readLineSync()!.toLowerCase();
    print('Введите год');
    inputDataModel.year = stdin.readLineSync()!.toLowerCase();
    print('Введите месяц(ангийскими буквами)');
    inputDataModel.month = stdin.readLineSync()!.toLowerCase();
    for (var i = 0; i < 1; i++) {
      countrys.add(inputDataModel.country);
      regions.add(inputDataModel.region);
    }
    await loadingData();
    await secondMenu();
  }

// Вторая менюка для рассмотрение созраненных данных
  secondMenu() async{
    print('[1] - 24 часовые погоды');
    print('[2] - посмотреть дневой данные');
    int menu = int.parse(stdin.readLineSync()!);
    switch (menu) {
      case 1:
        await hours24();
        goBack();
        break;
      case 2:
        print('Введите день');
        int day = int.parse(stdin.readLineSync()!);
        day -= 1;
        print(_listMyWeatherModel[day]);
        goBack();
        break;
      default:
        print('Нет такого меню ');
        goBack();
        break;
    }
  }

  Future loadingData() async {
    try {
      var isCheckToEmpty =
          await isEmptyBox<MyWeatherModel>(inputDataModel.toBoxName());
      if (isCheckToEmpty) {
        await getData();
      } else {
        _listMyWeatherModel =
            (await getBoxes<MyWeatherModel>(inputDataModel.toBoxName()))
                .values
                .toList();
      }
    } catch (e) {
      print('loadingData(): $e');
    }
  }

  Future getData() async {
    try {
      var responce = await get(
          Uri.parse("https://world-weather.ru/pogoda/${inputDataModel.query}"));
      if (responce.statusCode == 200) {
        var document = parser.parse(responce.body);
        List days = document.getElementsByTagName('li div');
        List daytitle = document.getElementsByTagName('li i');
        List weatherDays = document.getElementsByTagName('i~span');
        List weatherNights = document.getElementsByTagName('i~p');
        for (int i = 0; i < days.length; i++) {
          var model = MyWeatherModel();
          model.data = days[i].innerHtml;
          model.title = daytitle[i].attributes['title'];
          model.tempDay = weatherDays[i].innerHtml;
          model.tempNight = weatherNights[i].innerHtml;
          _listMyWeatherModel.add(model);
        }
        await addBoxes<MyWeatherModel>(
            inputDataModel.toBoxName(), _listMyWeatherModel);
      }
    } on SocketException {
      print(' Error with internet connection');
    } catch (e) {
      print('getDate: $e');
    }
  }

  //вывод 24 часовые данные
  Future hours24() async {
    var responce = await get(Uri.parse(
        "https://world-weather.ru/pogoda/${countrys[0]}/${regions[0]}/24hours/"));
    if (responce.statusCode == 200) {
      var document = parser.parse(responce.body);
      List night1 = document.getElementsByClassName("weather-day");
      List night2 = document.getElementsByClassName("weather-feeling");
      List night3 = document.getElementsByClassName("weather-probability");
      List night4 = document.getElementsByClassName("weather-pressure");
      List night5 = document.querySelectorAll('.weather-wind span~span');
      List night6 = document.getElementsByClassName("weather-humidity");
      int thisday = document.getElementsByClassName('day hourly-2').length;
      List page = [
        "Aтмосф. явл.темп С",
        "Ощущ как С ",
        "Вероят. осадка %",
        "Давл. мм рт.ст.",
        "Скор. ветра м/с",
        "Вл. воздуха"
      ];
      print('Часы' + '      ' + page.join('|'));
      for (int i = 0; i < thisday; i++) {
        print(night1[i].innerHtml +
            '       ' +
            '       ' +
            night2[i].innerHtml +
            '       ' +
            '    ' +
            night2[i].innerHtml +
            '     ' +
            '      ' +
            night3[i].innerHtml +
            '     ' +
            '       ' +
            night4[i].innerHtml +
            '     ' +
            '       ' +
            night5[i].innerHtml +
            '     ' +
            '       ' +
            night6[i].innerHtml);
      }
    }
  }

  goBack() {
    print('Чтобы вернутся на главное меню нажмите 0, чтобы выйти exit ');
    String n = stdin.readLineSync()!;
    if (n == '0') {
      secondMenu();
    } else if (n == 'exit') {
      exit(0);
    }
  }
}
