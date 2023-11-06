
import 'dart:convert';

import 'package:delivery_address/src/generated/json/around_placeV4_entity.g.dart';
import 'package:delivery_address/src/generated/json/base/json_field.dart';
export 'package:delivery_address/src/generated/json/around_placeV4_entity.g.dart';

@JsonSerializable()
class AroundPlaceV4Entity {
	late AroundPlaceV4Suggestion suggestion;
	late String count;
	late String infocode;
	late List<AroundPlaceV4Pois> pois;
	late String status;
	late String info;

	AroundPlaceV4Entity();

	factory AroundPlaceV4Entity.fromJson(Map<String, dynamic> json) => $AroundPlaceV4EntityFromJson(json);

	Map<String, dynamic> toJson() => $AroundPlaceV4EntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AroundPlaceV4Suggestion {
	late List<dynamic> keywords;
	late List<dynamic> cities;

	AroundPlaceV4Suggestion();

	factory AroundPlaceV4Suggestion.fromJson(Map<String, dynamic> json) => $AroundPlaceV4SuggestionFromJson(json);

	Map<String, dynamic> toJson() => $AroundPlaceV4SuggestionToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AroundPlaceV4Pois {
	late dynamic parent;
	late String address;
	late List<dynamic> distance;
	late String pname;
	late List<dynamic> importance;
	@JSONField(name: "biz_ext")
	late AroundPlaceV4PoisBizExt bizExt;
	@JSONField(name: "biz_type")
	late List<dynamic> bizType;
	late String cityname;
	late String type;
	late List<AroundPlaceV4PoisPhotos> photos;
	late String typecode;
	late String shopinfo;
	late List<dynamic> poiweight;
	late dynamic childtype;
	late String adname;
	late String name;
	late String location;
	late dynamic tel;
	late List<dynamic> shopid;
	late String id;

	AroundPlaceV4Pois();

	factory AroundPlaceV4Pois.fromJson(Map<String, dynamic> json) => $AroundPlaceV4PoisFromJson(json);

	Map<String, dynamic> toJson() => $AroundPlaceV4PoisToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AroundPlaceV4PoisBizExt {
	late List<dynamic> cost;
	late String rating;

	AroundPlaceV4PoisBizExt();

	factory AroundPlaceV4PoisBizExt.fromJson(Map<String, dynamic> json) => $AroundPlaceV4PoisBizExtFromJson(json);

	Map<String, dynamic> toJson() => $AroundPlaceV4PoisBizExtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AroundPlaceV4PoisPhotos {
	late List<dynamic> title;
	late String url;

	AroundPlaceV4PoisPhotos();

	factory AroundPlaceV4PoisPhotos.fromJson(Map<String, dynamic> json) => $AroundPlaceV4PoisPhotosFromJson(json);

	Map<String, dynamic> toJson() => $AroundPlaceV4PoisPhotosToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}