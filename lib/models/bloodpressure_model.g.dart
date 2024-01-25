// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloodpressure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressureModel _$BloodPressureModelFromJson(Map<String, dynamic> json) =>
    BloodPressureModel(
      bpmId: json['bpm_id'] as int,
      source: json['source'] as int?,
      sys: json['sys'] as int?,
      dia: json['dia'] as int?,
      pul: json['pul'] as int?,
      afib: json['afib'] as int?,
      pad: json['pad'] as int?,
      mode: json['mode'] as int?,
      updateDate: json['update_date'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$BloodPressureModelToJson(BloodPressureModel instance) =>
    <String, dynamic>{
      'bpm_id': instance.bpmId,
      'source': instance.source,
      'sys': instance.sys,
      'dia': instance.dia,
      'pul': instance.pul,
      'afib': instance.afib,
      'pad': instance.pad,
      'mode': instance.mode,
      'updat_date': instance.updateDate,
      'note': instance.note,
    };
