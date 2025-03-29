// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_pairing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WinePairingModel _$WinePairingModelFromJson(Map<String, dynamic> json) =>
    WinePairingModel(
      pairings:
          (json['pairings'] as List<dynamic>).map((e) => e as String).toList(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$WinePairingModelToJson(WinePairingModel instance) =>
    <String, dynamic>{
      'pairings': instance.pairings,
      'text': instance.text,
    };
