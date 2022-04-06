// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ebook_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenEbookMetadata _$GenEbookMetadataFromJson(Map<String, dynamic> json) =>
    GenEbookMetadata(
      title: json['title'] as String,
      authors:
          (json['authors'] as List<dynamic>).map((e) => e as String?).toList(),
      publishers: (json['publishers'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      filePath: json['filePath'] as String,
    );

Map<String, dynamic> _$GenEbookMetadataToJson(GenEbookMetadata instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publishers': instance.publishers,
      'filePath': instance.filePath,
    };
