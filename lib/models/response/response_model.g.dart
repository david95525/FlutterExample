// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      code: json['code'] as int,
      info: json['info'] as String,
      data: json['data'] == null
          ? null
          : UserModel.fromJson(json['data'] as Map<String, dynamic>),
      bpmData: json['bpmData'] == null
          ? null
          : List<BloodPressureModel>.from(json['bpmData']
              .map((model) => BloodPressureModel.fromJson(model))),
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'info': instance.info,
      'data': instance.data,
      'bpmData': instance.bpmData,
    };
