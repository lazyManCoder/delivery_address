import 'dart:convert';

import 'package:delivery_address/src/generated/json/base/json_field.dart';
import 'package:delivery_address/src/generated/json/country_format_entity.g.dart';
export 'package:delivery_address/src/generated/json/country_format_entity.g.dart';

@JsonSerializable()
class CountryFormatEntity {
	late String name;
	late String center;
	late List<CountryFormatEntity> districts;
	late String adcode;
	late String level;

	CountryFormatEntity();

	factory CountryFormatEntity.fromJson(Map<String, dynamic> json) => $CountryFormatEntityFromJson(json);

	Map<String, dynamic> toJson() => $CountryFormatEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CountryFormatDistricts {
	late String name;
	late String center;
	late List<CountryFormatDistrictsDistricts> districts;

	CountryFormatDistricts();

	factory CountryFormatDistricts.fromJson(Map<String, dynamic> json) => $CountryFormatDistrictsFromJson(json);

	Map<String, dynamic> toJson() => $CountryFormatDistrictsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CountryFormatDistrictsDistricts {
	late String name;
	late String center;
	late List<CountryFormatDistrictsDistrictsDistricts> districts;

	CountryFormatDistrictsDistricts();

	factory CountryFormatDistrictsDistricts.fromJson(Map<String, dynamic> json) => $CountryFormatDistrictsDistrictsFromJson(json);

	Map<String, dynamic> toJson() => $CountryFormatDistrictsDistrictsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CountryFormatDistrictsDistrictsDistricts {
	late String name;
	late String center;
	late List<dynamic> districts;

	CountryFormatDistrictsDistrictsDistricts();

	factory CountryFormatDistrictsDistrictsDistricts.fromJson(Map<String, dynamic> json) => $CountryFormatDistrictsDistrictsDistrictsFromJson(json);

	Map<String, dynamic> toJson() => $CountryFormatDistrictsDistrictsDistrictsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}