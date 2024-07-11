// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commonData_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommonDataModelAdapter extends TypeAdapter<CommonDataModel> {
  @override
  final int typeId = 0;

  @override
  CommonDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommonDataModel(
      messageCode: fields[0] as String?,
      message: fields[1] as String?,
      data: fields[2] as Data?,
      error: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, CommonDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.messageCode)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.error);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommonDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 1;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      message: fields[0] as String?,
      response: (fields[1] as List?)?.cast<Response>(),
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.response);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResponseAdapter extends TypeAdapter<Response> {
  @override
  final int typeId = 2;

  @override
  Response read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Response(
      lovCode: fields[0] as String?,
      values: (fields[1] as List?)?.cast<Values>(),
    );
  }

  @override
  void write(BinaryWriter writer, Response obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lovCode)
      ..writeByte(1)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ValuesAdapter extends TypeAdapter<Values> {
  @override
  final int typeId = 3;

  @override
  Values read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Values(
      code: fields[0] as String?,
      value: fields[1] as String?,
      valueArabic: fields[2] as String?,
      required: fields[3] as String?,
      hide: fields[4] as bool?,
      order: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Values obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.valueArabic)
      ..writeByte(3)
      ..write(obj.required)
      ..writeByte(4)
      ..write(obj.hide)
      ..writeByte(5)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValuesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
