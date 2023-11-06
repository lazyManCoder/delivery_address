
import 'package:delivery_address/src/generated/json/base/json_convert_content.dart';
import 'package:delivery_address/src/model/country_format_entity.dart';

CountryFormatEntity $CountryFormatEntityFromJson(Map<String, dynamic> json) {
  final CountryFormatEntity countryFormatEntity = CountryFormatEntity();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countryFormatEntity.name = name;
  }
  final String? center = jsonConvert.convert<String>(json['center']);
  if (center != null) {
    countryFormatEntity.center = center;
  }
  final List<CountryFormatEntity>? districts = (json['districts'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CountryFormatEntity>(e) as CountryFormatEntity)
      .toList();
  if (districts != null) {
    countryFormatEntity.districts = districts;
  }
  final String? adcode = jsonConvert.convert<String>(json['adcode']);
  if (adcode != null) {
    countryFormatEntity.adcode = adcode;
  }
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    countryFormatEntity.level = level;
  }
  return countryFormatEntity;
}

Map<String, dynamic> $CountryFormatEntityToJson(CountryFormatEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['center'] = entity.center;
  data['districts'] = entity.districts.map((v) => v.toJson()).toList();
  data['adcode'] = entity.adcode;
  data['level'] = entity.level;
  return data;
}

extension CountryFormatEntityExtension on CountryFormatEntity {
  CountryFormatEntity copyWith({
    String? name,
    String? center,
    List<CountryFormatEntity>? districts,
    String? adcode,
    String? level,
  }) {
    return CountryFormatEntity()
      ..name = name ?? this.name
      ..center = center ?? this.center
      ..districts = districts ?? this.districts
      ..adcode = adcode ?? this.adcode
      ..level = level ?? this.level;
  }
}

CountryFormatDistricts $CountryFormatDistrictsFromJson(
    Map<String, dynamic> json) {
  final CountryFormatDistricts countryFormatDistricts = CountryFormatDistricts();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countryFormatDistricts.name = name;
  }
  final String? center = jsonConvert.convert<String>(json['center']);
  if (center != null) {
    countryFormatDistricts.center = center;
  }
  final List<
      CountryFormatDistrictsDistricts>? districts = (json['districts'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CountryFormatDistrictsDistricts>(
          e) as CountryFormatDistrictsDistricts).toList();
  if (districts != null) {
    countryFormatDistricts.districts = districts;
  }
  return countryFormatDistricts;
}

Map<String, dynamic> $CountryFormatDistrictsToJson(
    CountryFormatDistricts entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['center'] = entity.center;
  data['districts'] = entity.districts.map((v) => v.toJson()).toList();
  return data;
}

extension CountryFormatDistrictsExtension on CountryFormatDistricts {
  CountryFormatDistricts copyWith({
    String? name,
    String? center,
    List<CountryFormatDistrictsDistricts>? districts,
  }) {
    return CountryFormatDistricts()
      ..name = name ?? this.name
      ..center = center ?? this.center
      ..districts = districts ?? this.districts;
  }
}

CountryFormatDistrictsDistricts $CountryFormatDistrictsDistrictsFromJson(
    Map<String, dynamic> json) {
  final CountryFormatDistrictsDistricts countryFormatDistrictsDistricts = CountryFormatDistrictsDistricts();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countryFormatDistrictsDistricts.name = name;
  }
  final String? center = jsonConvert.convert<String>(json['center']);
  if (center != null) {
    countryFormatDistrictsDistricts.center = center;
  }
  final List<
      CountryFormatDistrictsDistrictsDistricts>? districts = (json['districts'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CountryFormatDistrictsDistrictsDistricts>(
          e) as CountryFormatDistrictsDistrictsDistricts).toList();
  if (districts != null) {
    countryFormatDistrictsDistricts.districts = districts;
  }
  return countryFormatDistrictsDistricts;
}

Map<String, dynamic> $CountryFormatDistrictsDistrictsToJson(
    CountryFormatDistrictsDistricts entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['center'] = entity.center;
  data['districts'] = entity.districts.map((v) => v.toJson()).toList();
  return data;
}

extension CountryFormatDistrictsDistrictsExtension on CountryFormatDistrictsDistricts {
  CountryFormatDistrictsDistricts copyWith({
    String? name,
    String? center,
    List<CountryFormatDistrictsDistrictsDistricts>? districts,
  }) {
    return CountryFormatDistrictsDistricts()
      ..name = name ?? this.name
      ..center = center ?? this.center
      ..districts = districts ?? this.districts;
  }
}

CountryFormatDistrictsDistrictsDistricts $CountryFormatDistrictsDistrictsDistrictsFromJson(
    Map<String, dynamic> json) {
  final CountryFormatDistrictsDistrictsDistricts countryFormatDistrictsDistrictsDistricts = CountryFormatDistrictsDistrictsDistricts();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countryFormatDistrictsDistrictsDistricts.name = name;
  }
  final String? center = jsonConvert.convert<String>(json['center']);
  if (center != null) {
    countryFormatDistrictsDistrictsDistricts.center = center;
  }
  final List<dynamic>? districts = (json['districts'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (districts != null) {
    countryFormatDistrictsDistrictsDistricts.districts = districts;
  }
  return countryFormatDistrictsDistrictsDistricts;
}

Map<String, dynamic> $CountryFormatDistrictsDistrictsDistrictsToJson(
    CountryFormatDistrictsDistrictsDistricts entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['center'] = entity.center;
  data['districts'] = entity.districts;
  return data;
}

extension CountryFormatDistrictsDistrictsDistrictsExtension on CountryFormatDistrictsDistrictsDistricts {
  CountryFormatDistrictsDistrictsDistricts copyWith({
    String? name,
    String? center,
    List<dynamic>? districts,
  }) {
    return CountryFormatDistrictsDistrictsDistricts()
      ..name = name ?? this.name
      ..center = center ?? this.center
      ..districts = districts ?? this.districts;
  }
}