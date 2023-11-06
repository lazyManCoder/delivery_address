
import 'dart:convert';

import 'package:delivery_address/src/generated/json/base/json_field.dart';
import 'package:delivery_address/src/generated/json/country_info_entity.g.dart';
export 'package:delivery_address/src/generated/json/country_info_entity.g.dart';

@JsonSerializable()
class CountryInfoEntity {
	late dynamic citycode;
	late String adcode;
	late String name;
	late String center;
	late String level;
	late List<CountryInfoDistricts> districts;

	CountryInfoEntity();

	factory CountryInfoEntity.fromJson(Map<String, dynamic> json) => $CountryInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $CountryInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CountryInfoDistricts {
	late dynamic citycode;
	late String adcode;
	late String name;
	late String center;
	late String level;
	late List<CountryInfoDistrictsDistricts> districts;

	CountryInfoDistricts();

	factory CountryInfoDistricts.fromJson(Map<String, dynamic> json) => $CountryInfoDistrictsFromJson(json);

	Map<String, dynamic> toJson() => $CountryInfoDistrictsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CountryInfoDistrictsDistricts {
	late dynamic citycode;
	late String adcode;
	late String name;
	late String center;
	late String level;
	late List<CountryInfoDistrictsDistrictsDistricts> districts;

	CountryInfoDistrictsDistricts();

	factory CountryInfoDistrictsDistricts.fromJson(Map<String, dynamic> json) => $CountryInfoDistrictsDistrictsFromJson(json);

	Map<String, dynamic> toJson() => $CountryInfoDistrictsDistrictsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CountryInfoDistrictsDistrictsDistricts {
	late dynamic citycode;
	late String adcode;
	late String name;
	late String center;
	late String level;
	late List<dynamic> districts;

	CountryInfoDistrictsDistrictsDistricts();

	factory CountryInfoDistrictsDistrictsDistricts.fromJson(Map<String, dynamic> json) => $CountryInfoDistrictsDistrictsDistrictsFromJson(json);

	Map<String, dynamic> toJson() => $CountryInfoDistrictsDistrictsDistrictsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}