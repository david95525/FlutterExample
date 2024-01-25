import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bloodpressure_model.g.dart';

@JsonSerializable()
class BloodPressureModel extends Equatable {
  final int bpmId;
  final String? updateDate;
  final int? source;
  final int? sys;
  final int? dia;
  final int? pul;
  final int? afib;
  final int? pad;
  final int? mode;
  final String? note;
  const BloodPressureModel(
      {required this.bpmId,
      this.updateDate,
      this.source,
      this.sys,
      this.dia,
      this.pul,
      this.afib,
      this.pad,
      this.mode,
      this.note});
  factory BloodPressureModel.fromJson(Map<String, dynamic> json) =>
      _$BloodPressureModelFromJson(json);
  Map<String, dynamic> toJson() => _$BloodPressureModelToJson(this);
  @override
  String toString() =>
      "bpmId:$bpmId source:$source sys:$sys dia:$dia pul:$pul afib:$afib pad:$pad mode:$mode updateDate:$updateDate note:$note";

  @override
  List<Object?> get props =>
      [bpmId, source, sys, dia, pul, afib, pad, mode, updateDate, note];
}
