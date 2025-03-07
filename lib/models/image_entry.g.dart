// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageEntryAdapter extends TypeAdapter<ImageEntry> {
  @override
  final int typeId = 0;

  @override
  ImageEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageEntry(
      id: fields[0] as String,
      prompt: fields[1] as String,
      imageUrl: fields[2] as String,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ImageEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.prompt)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
