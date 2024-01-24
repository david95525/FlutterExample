// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      id: json['id'] as int,
      temperature: json['temperature'] as int,
      minTemperature: json['minTemperature'] as int,
      maxTemperature: json['maxTemperature'] as int,
      weatherTypes: json['weatherTypes'] as int,
      weatherDescription: json['weatherDescription'] as String,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'temperature': instance.temperature,
      'minTemperature': instance.minTemperature,
      'maxTemperature': instance.maxTemperature,
      'weatherTypes': instance.weatherTypes,
      'weatherDescription': instance.weatherDescription,
    };
