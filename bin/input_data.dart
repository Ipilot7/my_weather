class InputData {
  String? country;
  String? region;
  String? year;
  String? month;

  String toBoxName() => '$country-$region-$year-$month';

  String get query => '$country/$region/$month-$year/';
}
