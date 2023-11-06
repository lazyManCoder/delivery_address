
import 'dart:convert';

import 'package:delivery_address/src/generated/json/base/json_field.dart';
import 'package:delivery_address/src/generated/json/inverse_address_entity.g.dart';
export 'package:delivery_address/src/generated/json/inverse_address_entity.g.dart';

@JsonSerializable()
class InverseAddressEntity {
	late String status;
	late InverseAddressRegeocode regeocode;
	late String info;
	late String infocode;

	InverseAddressEntity();

	factory InverseAddressEntity.fromJson(Map<String, dynamic> json) => $InverseAddressEntityFromJson(json);

	Map<String, dynamic> toJson() => $InverseAddressEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class InverseAddressRegeocode {
	late List<InverseAddressRegeocodeRoads> roads;
	late List<InverseAddressRegeocodeRoadinters> roadinters;
	@JSONField(name: "formatted_address")
	late String formattedAddress;
	late InverseAddressRegeocodeAddressComponent addressComponent;
	late List<InverseAddressRegeocodeAois> aois;
	late List<InverseAddressRegeocodePois> pois;

	InverseAddressRegeocode();

	factory InverseAddressRegeocode.fromJson(Map<String, dynamic> json) => $InverseAddressRegeocodeFromJson(json);

	Map<String, dynamic> toJson() => $InverseAddressRegeocodeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class InverseAddressRegeocodeRoads {
	late String id;
	late String location;
	late String direction;
	late String name;
	late String distance;

	InverseAddressRegeocodeRoads();

	factory InverseAddressRegeocodeRoads.fromJson(Map<String, dynamic> json) => $InverseAddressRegeocodeRoadsFromJson(json);

	Map<String, dynamic> toJson() => $InverseAddressRegeocodeRoadsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class InverseAddressRegeocodeRoadinters {
	@JSONField(name: "second_name")
	late String secondName;
	@JSONField(name: "first_id")
	late String firstId;
	@JSONField(name: "second_id")
	late String secondId;
	late String location;
	late String distance;
	@JSONField(name: "first_name")
	late String firstName;
	late String direction;

	InverseAddressRegeocodeRoadinters();

	factory InverseAddressRegeocodeRoadinters.fromJson(Map<String, dynamic> json) => $InverseAddressRegeocodeRoadintersFromJson(json);

	Map<String, dynamic> toJson() => $InverseAddressRegeocodeRoadintersToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class InverseAddressRegeocodeAddressComponent {
	late String city;
	late String province;
	late String adcode;
	late String district;
	late String towncode;
	late InverseAddressRegeocodeAddressComponentStreetNumber streetNumber;
	late String country;
	late String township;
	late String citycode;

	InverseAddressRegeocodeAddressComponent();

	factory InverseAddressRegeocodeAddressComponent.fromJson(Map<String, dynamic> json) => $InverseAddressRegeocodeAddressComponentFromJson(json);

	Map<String, dynamic> toJson() => $InverseAddressRegeocodeAddressComponentToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class InverseAddressRegeocodeAddressComponentStreetNumber {
	late String number;
	late String location;
	late String direction;
	late String distance;
	late String street;

	InverseAddressRegeocodeAddressComponentStreetNumber();

	factory InverseAddressRegeocodeAddressComponentStreetNumber.fromJson(Map<String, dynamic> json) => $InverseAddressRegeocodeAddressComponentStreetNumberFromJson(json);

	Map<String, dynamic> toJson() => $InverseAddressRegeocodeAddressComponentStreetNumberToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class InverseAddressRegeocodeAois {
	late String area;
	late String type;
	late String id;
	late String location;
	late String adcode;
	late String name;
	late String distance;

	InverseAddressRegeocodeAois();

	factory InverseAddressRegeocodeAois.fromJson(Map<String, dynamic> json) => $InverseAddressRegeocodeAoisFromJson(json);

	Map<String, dynamic> toJson() => $InverseAddressRegeocodeAoisToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class InverseAddressRegeocodePois {
	late String id;
	late String direction;
	late dynamic businessarea;
	late String address;
	late String poiweight;
	late String name;
	late String location;
	late String distance;
	late dynamic tel;
	late String type;

	InverseAddressRegeocodePois();

	factory InverseAddressRegeocodePois.fromJson(Map<String, dynamic> json) => $InverseAddressRegeocodePoisFromJson(json);

	Map<String, dynamic> toJson() => $InverseAddressRegeocodePoisToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}