// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      image: json['image'] as String,
      imageType: json['imageType'] as String,
      dishTypes: json['dishTypes'] != null
        ? (json['dishTypes'] as List<dynamic>).map((e) => e as String).toList()
          : [],  // ใช้ list ว่างถ้าเป็น null
      vegetarian: json['vegetarian'] as bool? ?? false,  // ใช้ false ถ้าเป็น null
      readyInMinutes: (json['readyInMinutes'] as num?)?.toInt() ?? 0, //ถ้า null ให้ใช้ 0
      preparationMinutes: (json['preparationMinutes'] as num?)?.toInt(),
      cookingMinutes: (json['cookingMinutes'] as num?)?.toInt(),
      // เพิ่มการตรวจสอบ null สำหรับ extendedIngredients
      extendedIngredients: json['extendedIngredients'] != null
          ? (json['extendedIngredients'] as List<dynamic>)
              .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'imageType': instance.imageType,
      'dishTypes': instance.dishTypes,
      'vegetarian': instance.vegetarian,
      'readyInMinutes': instance.readyInMinutes,
      'preparationMinutes': instance.preparationMinutes,
      'cookingMinutes': instance.cookingMinutes,
      'extendedIngredients': instance.extendedIngredients,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'] as String?,
      aisle: json['aisle'] as String?,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'unit': instance.unit,
      'aisle': instance.aisle,
    };
