part of 'weather_model.dart';

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      id: json['result']['resource_id'] as String,
      temperature: json['result']['records']['locations'][0] as int,
      minTemperature: json['minTemperature'] as int,
      maxTemperature: json['maxTemperature'] as int,
      weatherTypes: json['weatherTypes'] as int,
      weatherDescription: json['weatherDescription'] as String,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'temperature': instance.temperature,
      'minTemperature': instance.minTemperature,
      'maxTemperature': instance.maxTemperature,
      'weatherTypes': instance.weatherTypes,
      'weatherDescription': instance.weatherDescription,
    };
