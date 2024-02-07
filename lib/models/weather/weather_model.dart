import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends Equatable {
  final String id;
  final int temperature;
  final int minTemperature;
  final int maxTemperature;
  final int weatherTypes;
  final String weatherDescription;
  const WeatherModel(
      {required this.id,
      required this.temperature,
      required this.minTemperature,
      required this.maxTemperature,
      required this.weatherTypes,
      required this.weatherDescription});
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
  @override
  String toString() =>
      "$id $temperature $minTemperature $maxTemperature $weatherTypes $weatherDescription";

  @override
  List<Object?> get props => [
        id,
        temperature,
        minTemperature,
        maxTemperature,
        weatherTypes,
        weatherDescription
      ];
}