

import 'package:delivery_address/src/generated/json/base/json_convert_content.dart';
import 'package:delivery_address/src/model/around_placeV4_entity.dart';

AroundPlaceV4Entity $AroundPlaceV4EntityFromJson(Map<String, dynamic> json) {
  final AroundPlaceV4Entity aroundPlaceV4Entity = AroundPlaceV4Entity();
  final AroundPlaceV4Suggestion? suggestion = jsonConvert.convert<
      AroundPlaceV4Suggestion>(json['suggestion']);
  if (suggestion != null) {
    aroundPlaceV4Entity.suggestion = suggestion;
  }
  final String? count = jsonConvert.convert<String>(json['count']);
  if (count != null) {
    aroundPlaceV4Entity.count = count;
  }
  final String? infocode = jsonConvert.convert<String>(json['infocode']);
  if (infocode != null) {
    aroundPlaceV4Entity.infocode = infocode;
  }
  final List<AroundPlaceV4Pois>? pois = (json['pois'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<AroundPlaceV4Pois>(e) as AroundPlaceV4Pois)
      .toList();
  if (pois != null) {
    aroundPlaceV4Entity.pois = pois;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    aroundPlaceV4Entity.status = status;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    aroundPlaceV4Entity.info = info;
  }
  return aroundPlaceV4Entity;
}

Map<String, dynamic> $AroundPlaceV4EntityToJson(AroundPlaceV4Entity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['suggestion'] = entity.suggestion.toJson();
  data['count'] = entity.count;
  data['infocode'] = entity.infocode;
  data['pois'] = entity.pois.map((v) => v.toJson()).toList();
  data['status'] = entity.status;
  data['info'] = entity.info;
  return data;
}

extension AroundPlaceV4EntityExtension on AroundPlaceV4Entity {
  AroundPlaceV4Entity copyWith({
    AroundPlaceV4Suggestion? suggestion,
    String? count,
    String? infocode,
    List<AroundPlaceV4Pois>? pois,
    String? status,
    String? info,
  }) {
    return AroundPlaceV4Entity()
      ..suggestion = suggestion ?? this.suggestion
      ..count = count ?? this.count
      ..infocode = infocode ?? this.infocode
      ..pois = pois ?? this.pois
      ..status = status ?? this.status
      ..info = info ?? this.info;
  }
}

AroundPlaceV4Suggestion $AroundPlaceV4SuggestionFromJson(
    Map<String, dynamic> json) {
  final AroundPlaceV4Suggestion aroundPlaceV4Suggestion = AroundPlaceV4Suggestion();
  final List<dynamic>? keywords = (json['keywords'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (keywords != null) {
    aroundPlaceV4Suggestion.keywords = keywords;
  }
  final List<dynamic>? cities = (json['cities'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (cities != null) {
    aroundPlaceV4Suggestion.cities = cities;
  }
  return aroundPlaceV4Suggestion;
}

Map<String, dynamic> $AroundPlaceV4SuggestionToJson(
    AroundPlaceV4Suggestion entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['keywords'] = entity.keywords;
  data['cities'] = entity.cities;
  return data;
}

extension AroundPlaceV4SuggestionExtension on AroundPlaceV4Suggestion {
  AroundPlaceV4Suggestion copyWith({
    List<dynamic>? keywords,
    List<dynamic>? cities,
  }) {
    return AroundPlaceV4Suggestion()
      ..keywords = keywords ?? this.keywords
      ..cities = cities ?? this.cities;
  }
}

AroundPlaceV4Pois $AroundPlaceV4PoisFromJson(Map<String, dynamic> json) {
  final AroundPlaceV4Pois aroundPlaceV4Pois = AroundPlaceV4Pois();
  final dynamic parent = json['parent'];
  if (parent != null) {
    aroundPlaceV4Pois.parent = parent;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    aroundPlaceV4Pois.address = address;
  }
  final List<dynamic>? distance = (json['distance'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (distance != null) {
    aroundPlaceV4Pois.distance = distance;
  }
  final String? pname = jsonConvert.convert<String>(json['pname']);
  if (pname != null) {
    aroundPlaceV4Pois.pname = pname;
  }
  final List<dynamic>? importance = (json['importance'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (importance != null) {
    aroundPlaceV4Pois.importance = importance;
  }
  final AroundPlaceV4PoisBizExt? bizExt = jsonConvert.convert<
      AroundPlaceV4PoisBizExt>(json['biz_ext']);
  if (bizExt != null) {
    aroundPlaceV4Pois.bizExt = bizExt;
  }
  final List<dynamic>? bizType = (json['biz_type'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (bizType != null) {
    aroundPlaceV4Pois.bizType = bizType;
  }
  final String? cityname = jsonConvert.convert<String>(json['cityname']);
  if (cityname != null) {
    aroundPlaceV4Pois.cityname = cityname;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    aroundPlaceV4Pois.type = type;
  }
  final List<AroundPlaceV4PoisPhotos>? photos = (json['photos'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<AroundPlaceV4PoisPhotos>(
          e) as AroundPlaceV4PoisPhotos).toList();
  if (photos != null) {
    aroundPlaceV4Pois.photos = photos;
  }
  final String? typecode = jsonConvert.convert<String>(json['typecode']);
  if (typecode != null) {
    aroundPlaceV4Pois.typecode = typecode;
  }
  final String? shopinfo = jsonConvert.convert<String>(json['shopinfo']);
  if (shopinfo != null) {
    aroundPlaceV4Pois.shopinfo = shopinfo;
  }
  final List<dynamic>? poiweight = (json['poiweight'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (poiweight != null) {
    aroundPlaceV4Pois.poiweight = poiweight;
  }
  final dynamic childtype = json['childtype'];
  if (childtype != null) {
    aroundPlaceV4Pois.childtype = childtype;
  }
  final String? adname = jsonConvert.convert<String>(json['adname']);
  if (adname != null) {
    aroundPlaceV4Pois.adname = adname;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    aroundPlaceV4Pois.name = name;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    aroundPlaceV4Pois.location = location;
  }
  final dynamic tel = json['tel'];
  if (tel != null) {
    aroundPlaceV4Pois.tel = tel;
  }
  final List<dynamic>? shopid = (json['shopid'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (shopid != null) {
    aroundPlaceV4Pois.shopid = shopid;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    aroundPlaceV4Pois.id = id;
  }
  return aroundPlaceV4Pois;
}

Map<String, dynamic> $AroundPlaceV4PoisToJson(AroundPlaceV4Pois entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['parent'] = entity.parent;
  data['address'] = entity.address;
  data['distance'] = entity.distance;
  data['pname'] = entity.pname;
  data['importance'] = entity.importance;
  data['biz_ext'] = entity.bizExt.toJson();
  data['biz_type'] = entity.bizType;
  data['cityname'] = entity.cityname;
  data['type'] = entity.type;
  data['photos'] = entity.photos.map((v) => v.toJson()).toList();
  data['typecode'] = entity.typecode;
  data['shopinfo'] = entity.shopinfo;
  data['poiweight'] = entity.poiweight;
  data['childtype'] = entity.childtype;
  data['adname'] = entity.adname;
  data['name'] = entity.name;
  data['location'] = entity.location;
  data['tel'] = entity.tel;
  data['shopid'] = entity.shopid;
  data['id'] = entity.id;
  return data;
}

extension AroundPlaceV4PoisExtension on AroundPlaceV4Pois {
  AroundPlaceV4Pois copyWith({
    dynamic parent,
    String? address,
    List<dynamic>? distance,
    String? pname,
    List<dynamic>? importance,
    AroundPlaceV4PoisBizExt? bizExt,
    List<dynamic>? bizType,
    String? cityname,
    String? type,
    List<AroundPlaceV4PoisPhotos>? photos,
    String? typecode,
    String? shopinfo,
    List<dynamic>? poiweight,
    dynamic childtype,
    String? adname,
    String? name,
    String? location,
    dynamic tel,
    List<dynamic>? shopid,
    String? id,
  }) {
    return AroundPlaceV4Pois()
      ..parent = parent ?? this.parent
      ..address = address ?? this.address
      ..distance = distance ?? this.distance
      ..pname = pname ?? this.pname
      ..importance = importance ?? this.importance
      ..bizExt = bizExt ?? this.bizExt
      ..bizType = bizType ?? this.bizType
      ..cityname = cityname ?? this.cityname
      ..type = type ?? this.type
      ..photos = photos ?? this.photos
      ..typecode = typecode ?? this.typecode
      ..shopinfo = shopinfo ?? this.shopinfo
      ..poiweight = poiweight ?? this.poiweight
      ..childtype = childtype ?? this.childtype
      ..adname = adname ?? this.adname
      ..name = name ?? this.name
      ..location = location ?? this.location
      ..tel = tel ?? this.tel
      ..shopid = shopid ?? this.shopid
      ..id = id ?? this.id;
  }
}

AroundPlaceV4PoisBizExt $AroundPlaceV4PoisBizExtFromJson(
    Map<String, dynamic> json) {
  final AroundPlaceV4PoisBizExt aroundPlaceV4PoisBizExt = AroundPlaceV4PoisBizExt();
  final List<dynamic>? cost = (json['cost'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (cost != null) {
    aroundPlaceV4PoisBizExt.cost = cost;
  }
  final String? rating = jsonConvert.convert<String>(json['rating']);
  if (rating != null) {
    aroundPlaceV4PoisBizExt.rating = rating;
  }
  return aroundPlaceV4PoisBizExt;
}

Map<String, dynamic> $AroundPlaceV4PoisBizExtToJson(
    AroundPlaceV4PoisBizExt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cost'] = entity.cost;
  data['rating'] = entity.rating;
  return data;
}

extension AroundPlaceV4PoisBizExtExtension on AroundPlaceV4PoisBizExt {
  AroundPlaceV4PoisBizExt copyWith({
    List<dynamic>? cost,
    String? rating,
  }) {
    return AroundPlaceV4PoisBizExt()
      ..cost = cost ?? this.cost
      ..rating = rating ?? this.rating;
  }
}

AroundPlaceV4PoisPhotos $AroundPlaceV4PoisPhotosFromJson(
    Map<String, dynamic> json) {
  final AroundPlaceV4PoisPhotos aroundPlaceV4PoisPhotos = AroundPlaceV4PoisPhotos();
  final List<dynamic>? title = (json['title'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (title != null) {
    aroundPlaceV4PoisPhotos.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    aroundPlaceV4PoisPhotos.url = url;
  }
  return aroundPlaceV4PoisPhotos;
}

Map<String, dynamic> $AroundPlaceV4PoisPhotosToJson(
    AroundPlaceV4PoisPhotos entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['url'] = entity.url;
  return data;
}

extension AroundPlaceV4PoisPhotosExtension on AroundPlaceV4PoisPhotos {
  AroundPlaceV4PoisPhotos copyWith({
    List<dynamic>? title,
    String? url,
  }) {
    return AroundPlaceV4PoisPhotos()
      ..title = title ?? this.title
      ..url = url ?? this.url;
  }
}