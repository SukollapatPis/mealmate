import 'package:json_annotation/json_annotation.dart';

part 'wine_pairing_model.g.dart';

@JsonSerializable()
class WinePairingModel {
  final List<String> pairings;
  final String text;

  WinePairingModel({
    required this.pairings,
    required this.text,
  });

  /// factory.
  factory WinePairingModel.fromJson(Map<String, dynamic> json) => _$WinePairingModelFromJson(json);

  /// Connect the generated [_$WinePairingModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WinePairingModelToJson(this);
}