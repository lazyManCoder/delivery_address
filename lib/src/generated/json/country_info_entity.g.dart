

import 'package:delivery_address/src/generated/json/base/json_convert_content.dart';
import 'package:delivery_address/src/model/country_info_entity.dart';

CountryInfoEntity $CountryInfoEntityFromJson(Map<String, dynamic> json) {
  final CountryInfoEntity countryInfoEntity = CountryInfoEntity();
  final dynamic citycode = json['citycode'];
  if (citycode != null) {
    countryInfoEntity.citycode = citycode;
  }
  final String? adcode = jsonConvert.convert<String>(json['adcode']);
  if (adcode != null) {
    countryInfoEntity.adcode = adcode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countryInfoEntity.name = name;
  }
  final String? center = jsonConvert.convert<String>(json['center']);
  if (center != null) {
    countryInfoEntity.center = center;
  }
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    countryInfoEntity.level = level;
  }
  final List<CountryInfoDistricts>? districts = (json['districts'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CountryInfoDistricts>(e) as CountryInfoDistricts)
      .toList();
  if (districts != null) {
    countryInfoEntity.districts = districts;
  }
  return countryInfoEntity;
}

Map<String, dynamic> $CountryInfoEntityToJson(CountryInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['citycode'] = entity.citycode;
  data['adcode'] = entity.adcode;
  data['name'] = entity.name;
  data['center'] = entity.center;
  data['level'] = entity.level;
  data['districts'] = entity.districts.map((v) => v.toJson()).toList();
  return data;
}

extension CountryInfoEntityExtension on CountryInfoEntity {
  CountryInfoEntity copyWith({
    dynamic citycode,
    String? adcode,
    String? name,
    String? center,
    String? level,
    List<CountryInfoDistricts>? districts,
  }) {
    return CountryInfoEntity()
      ..citycode = citycode ?? this.citycode
      ..adcode = adcode ?? this.adcode
      ..name = name ?? this.name
      ..center = center ?? this.center
      ..level = level ?? this.level
      ..districts = districts ?? this.districts;
  }
}

CountryInfoDistricts $CountryInfoDistrictsFromJson(Map<String, dynamic> json) {
  final CountryInfoDistricts countryInfoDistricts = CountryInfoDistricts();
  final dynamic citycode = json['citycode'];
  if (citycode != null) {
    countryInfoDistricts.citycode = citycode;
  }
  final String? adcode = jsonConvert.convert<String>(json['adcode']);
  if (adcode != null) {
    countryInfoDistricts.adcode = adcode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countryInfoDistricts.name = name;
  }
  final String? center = jsonConvert.convert<String>(json['center']);
  if (center != null) {
    countryInfoDistricts.center = center;
  }
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    countryInfoDistricts.level = level;
  }
  final List<
      CountryInfoDistrictsDistricts>? districts = (json['districts'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CountryInfoDistrictsDistricts>(
          e) as CountryInfoDistrictsDistricts).toList();
  if (districts != null) {
    countryInfoDistricts.districts = districts;
  }
  return countryInfoDistricts;
}

Map<String, dynamic> $CountryInfoDistrictsToJson(CountryInfoDistricts entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['citycode'] = entity.citycode;
  data['adcode'] = entity.adcode;
  data['name'] = entity.name;
  data['center'] = entity.center;
  data['level'] = entity.level;
  data['districts'] = entity.districts.map((v) => v.toJson()).toList();
  return data;
}

extension CountryInfoDistrictsExtension on CountryInfoDistricts {
  CountryInfoDistricts copyWith({
    dynamic citycode,
    String? adcode,
    String? name,
    String? center,
    String? level,
    List<CountryInfoDistrictsDistricts>? districts,
  }) {
    return CountryInfoDistricts()
      ..citycode = citycode ?? this.citycode
      ..adcode = adcode ?? this.adcode
      ..name = name ?? this.name
      ..center = center ?? this.center
      ..level = level ?? this.level
      ..districts = districts ?? this.districts;
  }
}

CountryInfoDistrictsDistricts $CountryInfoDistrictsDistrictsFromJson(
    Map<String, dynamic> json) {
  final CountryInfoDistrictsDistricts countryInfoDistrictsDistricts = CountryInfoDistrictsDistricts();
  final dynamic citycode = json['citycode'];
  if (citycode != null) {
    countryInfoDistrictsDistricts.citycode = citycode;
  }
  final String? adcode = jsonConvert.convert<String>(json['adcode']);
  if (adcode != null) {
    countryInfoDistrictsDistricts.adcode = adcode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countryInfoDistrictsDistricts.name = name;
  }
  final String? center = jsonConvert.convert<String>(json['center']);
  if (center != null) {
    countryInfoDistrictsDistricts.center = center;
  }
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    countryInfoDistrictsDistricts.level = level;
  }
  final List<
      CountryInfoDistrictsDistrictsDistricts>? districts = (json['districts'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CountryInfoDistrictsDistrictsDistricts>(
          e) as CountryInfoDistrictsDistrictsDistricts).toList();
  if (districts != null) {
    countryInfoDistrictsDistricts.districts = districts;
  }
  return countryInfoDistrictsDistricts;
}

Map<String, dynamic> $CountryInfoDistrictsDistrictsToJson(
    CountryInfoDistrictsDistricts entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['citycode'] = entity.citycode;
  data['adcode'] = entity.adcode;
  data['name'] = entity.name;
  data['center'] = entity.center;
  data['level'] = entity.level;
  data['districts'] = entity.districts.map((v) => v.toJson()).toList();
  return data;
}

extension CountryInfoDistrictsDistrictsExtension on CountryInfoDistrictsDistricts {
  CountryInfoDistrictsDistricts copyWith({
    dynamic citycode,
    String? adcode,
    String? name,
    String? center,
    String? level,
    List<CountryInfoDistrictsDistrictsDistricts>? districts,
  }) {
    return CountryInfoDistrictsDistricts()
      ..citycode = citycode ?? this.citycode
      ..adcode = adcode ?? this.adcode
      ..name = name ?? this.name
      ..center = center ?? this.center
      ..level = level ?? this.level
      ..districts = districts ?? this.districts;
  }
}

CountryInfoDistrictsDistrictsDistricts $CountryInfoDistrictsDistrictsDistrictsFromJson(
    Map<String, dynamic> json) {
  final CountryInfoDistrictsDistrictsDistricts countryInfoDistrictsDistrictsDistricts = CountryInfoDistrictsDistrictsDistricts();
  final dynamic citycode = json['citycode'];
  if (citycode != null) {
    countryInfoDistrictsDistrictsDistricts.citycode = citycode;
  }
  final String? adcode = jsonConvert.convert<String>(json['adcode']);
  if (adcode != null) {
    countryInfoDistrictsDistrictsDistricts.adcode = adcode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countryInfoDistrictsDistrictsDistricts.name = name;
  }
  final String? center = jsonConvert.convert<String>(json['center']);
  if (center != null) {
    countryInfoDistrictsDistrictsDistricts.center = center;
  }
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    countryInfoDistrictsDistrictsDistricts.level = level;
  }
  final List<dynamic>? districts = (json['districts'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (districts != null) {
    countryInfoDistrictsDistrictsDistricts.districts = districts;
  }
  return countryInfoDistrictsDistrictsDistricts;
}

Map<String, dynamic> $CountryInfoDistrictsDistrictsDistrictsToJson(
    CountryInfoDistrictsDistrictsDistricts entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['citycode'] = entity.citycode;
  data['adcode'] = entity.adcode;
  data['name'] = entity.name;
  data['center'] = entity.center;
  data['level'] = entity.level;
  data['districts'] = entity.districts;
  return data;
}

extension CountryInfoDistrictsDistrictsDistrictsExtension on CountryInfoDistrictsDistrictsDistricts {
  CountryInfoDistrictsDistrictsDistricts copyWith({
    dynamic citycode,
    String? adcode,
    String? name,
    String? center,
    String? level,
    List<dynamic>? districts,
  }) {
    return CountryInfoDistrictsDistrictsDistricts()
      ..citycode = citycode ?? this.citycode
      ..adcode = adcode ?? this.adcode
      ..name = name ?? this.name
      ..center = center ?? this.center
      ..level = level ?? this.level
      ..districts = districts ?? this.districts;
  }
}