// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaVOAdapter extends TypeAdapter<CinemaVO> {
  @override
  final int typeId = 7;

  @override
  CinemaVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaVO(
      cinemaId: fields[0] as int?,
      cinema: fields[1] as String?,
      timeSlots: (fields[2] as List?)?.cast<TimeSlotVO>(),
    )..isSelected = fields[3] as bool?;
  }

  @override
  void write(BinaryWriter writer, CinemaVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cinemaId)
      ..writeByte(1)
      ..write(obj.cinema)
      ..writeByte(2)
      ..write(obj.timeSlots)
      ..writeByte(3)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaVO _$CinemaVOFromJson(Map<String, dynamic> json) => CinemaVO(
      cinemaId: json['cinema_id'] as int?,
      cinema: json['cinema'] as String?,
      timeSlots: (json['timeslots'] as List<dynamic>?)
          ?.map((e) => TimeSlotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..isSelected = json['isSelected'] as bool?;

Map<String, dynamic> _$CinemaVOToJson(CinemaVO instance) => <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinema,
      'timeslots': instance.timeSlots,
      'isSelected': instance.isSelected,
    };
