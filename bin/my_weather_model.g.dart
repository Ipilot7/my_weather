// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyWeatherModelAdapter extends TypeAdapter<MyWeatherModel> {
  @override
  final int typeId = 0;

  @override
  MyWeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyWeatherModel(
      title: fields[0] as String?,
      data: fields[1] as String?,
      tempDay: fields[2] as String?,
      tempNight: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MyWeatherModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.tempDay)
      ..writeByte(3)
      ..write(obj.tempNight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyWeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
