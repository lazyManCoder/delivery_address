

import 'package:delivery_address/src/generated/json/base/json_convert_content.dart';
import 'package:delivery_address/src/model/inverse_address_entity.dart';

InverseAddressEntity $InverseAddressEntityFromJson(Map<String, dynamic> json) {
  final InverseAddressEntity inverseAddressEntity = InverseAddressEntity();
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    inverseAddressEntity.status = status;
  }
  final InverseAddressRegeocode? regeocode = jsonConvert.convert<
      InverseAddressRegeocode>(json['regeocode']);
  if (regeocode != null) {
    inverseAddressEntity.regeocode = regeocode;
  }
  final String? info = jsonConvert.convert<String>(json['info']);
  if (info != null) {
    inverseAddressEntity.info = info;
  }
  final String? infocode = jsonConvert.convert<String>(json['infocode']);
  if (infocode != null) {
    inverseAddressEntity.infocode = infocode;
  }
  return inverseAddressEntity;
}

Map<String, dynamic> $InverseAddressEntityToJson(InverseAddressEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['regeocode'] = entity.regeocode.toJson();
  data['info'] = entity.info;
  data['infocode'] = entity.infocode;
  return data;
}

extension InverseAddressEntityExtension on InverseAddressEntity {
  InverseAddressEntity copyWith({
    String? status,
    InverseAddressRegeocode? regeocode,
    String? info,
    String? infocode,
  }) {
    return InverseAddressEntity()
      ..status = status ?? this.status
      ..regeocode = regeocode ?? this.regeocode
      ..info = info ?? this.info
      ..infocode = infocode ?? this.infocode;
  }
}

InverseAddressRegeocode $InverseAddressRegeocodeFromJson(
    Map<String, dynamic> json) {
  final InverseAddressRegeocode inverseAddressRegeocode = InverseAddressRegeocode();
  final List<InverseAddressRegeocodeRoads>? roads = (json['roads'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<InverseAddressRegeocodeRoads>(
          e) as InverseAddressRegeocodeRoads).toList();
  if (roads != null) {
    inverseAddressRegeocode.roads = roads;
  }
  final List<
      InverseAddressRegeocodeRoadinters>? roadinters = (json['roadinters'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<InverseAddressRegeocodeRoadinters>(
          e) as InverseAddressRegeocodeRoadinters).toList();
  if (roadinters != null) {
    inverseAddressRegeocode.roadinters = roadinters;
  }
  final String? formattedAddress = jsonConvert.convert<String>(
      json['formatted_address']);
  if (formattedAddress != null) {
    inverseAddressRegeocode.formattedAddress = formattedAddress;
  }
  final InverseAddressRegeocodeAddressComponent? addressComponent = jsonConvert
      .convert<InverseAddressRegeocodeAddressComponent>(
      json['addressComponent']);
  if (addressComponent != null) {
    inverseAddressRegeocode.addressComponent = addressComponent;
  }
  final List<InverseAddressRegeocodeAois>? aois = (json['aois'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<InverseAddressRegeocodeAois>(
          e) as InverseAddressRegeocodeAois).toList();
  if (aois != null) {
    inverseAddressRegeocode.aois = aois;
  }
  final List<InverseAddressRegeocodePois>? pois = (json['pois'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<InverseAddressRegeocodePois>(
          e) as InverseAddressRegeocodePois).toList();
  if (pois != null) {
    inverseAddressRegeocode.pois = pois;
  }
  return inverseAddressRegeocode;
}

Map<String, dynamic> $InverseAddressRegeocodeToJson(
    InverseAddressRegeocode entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['roads'] = entity.roads.map((v) => v.toJson()).toList();
  data['roadinters'] = entity.roadinters.map((v) => v.toJson()).toList();
  data['formatted_address'] = entity.formattedAddress;
  data['addressComponent'] = entity.addressComponent.toJson();
  data['aois'] = entity.aois.map((v) => v.toJson()).toList();
  data['pois'] = entity.pois.map((v) => v.toJson()).toList();
  return data;
}

extension InverseAddressRegeocodeExtension on InverseAddressRegeocode {
  InverseAddressRegeocode copyWith({
    List<InverseAddressRegeocodeRoads>? roads,
    List<InverseAddressRegeocodeRoadinters>? roadinters,
    String? formattedAddress,
    InverseAddressRegeocodeAddressComponent? addressComponent,
    List<InverseAddressRegeocodeAois>? aois,
    List<InverseAddressRegeocodePois>? pois,
  }) {
    return InverseAddressRegeocode()
      ..roads = roads ?? this.roads
      ..roadinters = roadinters ?? this.roadinters
      ..formattedAddress = formattedAddress ?? this.formattedAddress
      ..addressComponent = addressComponent ?? this.addressComponent
      ..aois = aois ?? this.aois
      ..pois = pois ?? this.pois;
  }
}

InverseAddressRegeocodeRoads $InverseAddressRegeocodeRoadsFromJson(
    Map<String, dynamic> json) {
  final InverseAddressRegeocodeRoads inverseAddressRegeocodeRoads = InverseAddressRegeocodeRoads();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    inverseAddressRegeocodeRoads.id = id;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    inverseAddressRegeocodeRoads.location = location;
  }
  final String? direction = jsonConvert.convert<String>(json['direction']);
  if (direction != null) {
    inverseAddressRegeocodeRoads.direction = direction;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    inverseAddressRegeocodeRoads.name = name;
  }
  final String? distance = jsonConvert.convert<String>(json['distance']);
  if (distance != null) {
    inverseAddressRegeocodeRoads.distance = distance;
  }
  return inverseAddressRegeocodeRoads;
}

Map<String, dynamic> $InverseAddressRegeocodeRoadsToJson(
    InverseAddressRegeocodeRoads entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['location'] = entity.location;
  data['direction'] = entity.direction;
  data['name'] = entity.name;
  data['distance'] = entity.distance;
  return data;
}

extension InverseAddressRegeocodeRoadsExtension on InverseAddressRegeocodeRoads {
  InverseAddressRegeocodeRoads copyWith({
    String? id,
    String? location,
    String? direction,
    String? name,
    String? distance,
  }) {
    return InverseAddressRegeocodeRoads()
      ..id = id ?? this.id
      ..location = location ?? this.location
      ..direction = direction ?? this.direction
      ..name = name ?? this.name
      ..distance = distance ?? this.distance;
  }
}

InverseAddressRegeocodeRoadinters $InverseAddressRegeocodeRoadintersFromJson(
    Map<String, dynamic> json) {
  final InverseAddressRegeocodeRoadinters inverseAddressRegeocodeRoadinters = InverseAddressRegeocodeRoadinters();
  final String? secondName = jsonConvert.convert<String>(json['second_name']);
  if (secondName != null) {
    inverseAddressRegeocodeRoadinters.secondName = secondName;
  }
  final String? firstId = jsonConvert.convert<String>(json['first_id']);
  if (firstId != null) {
    inverseAddressRegeocodeRoadinters.firstId = firstId;
  }
  final String? secondId = jsonConvert.convert<String>(json['second_id']);
  if (secondId != null) {
    inverseAddressRegeocodeRoadinters.secondId = secondId;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    inverseAddressRegeocodeRoadinters.location = location;
  }
  final String? distance = jsonConvert.convert<String>(json['distance']);
  if (distance != null) {
    inverseAddressRegeocodeRoadinters.distance = distance;
  }
  final String? firstName = jsonConvert.convert<String>(json['first_name']);
  if (firstName != null) {
    inverseAddressRegeocodeRoadinters.firstName = firstName;
  }
  final String? direction = jsonConvert.convert<String>(json['direction']);
  if (direction != null) {
    inverseAddressRegeocodeRoadinters.direction = direction;
  }
  return inverseAddressRegeocodeRoadinters;
}

Map<String, dynamic> $InverseAddressRegeocodeRoadintersToJson(
    InverseAddressRegeocodeRoadinters entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['second_name'] = entity.secondName;
  data['first_id'] = entity.firstId;
  data['second_id'] = entity.secondId;
  data['location'] = entity.location;
  data['distance'] = entity.distance;
  data['first_name'] = entity.firstName;
  data['direction'] = entity.direction;
  return data;
}

extension InverseAddressRegeocodeRoadintersExtension on InverseAddressRegeocodeRoadinters {
  InverseAddressRegeocodeRoadinters copyWith({
    String? secondName,
    String? firstId,
    String? secondId,
    String? location,
    String? distance,
    String? firstName,
    String? direction,
  }) {
    return InverseAddressRegeocodeRoadinters()
      ..secondName = secondName ?? this.secondName
      ..firstId = firstId ?? this.firstId
      ..secondId = secondId ?? this.secondId
      ..location = location ?? this.location
      ..distance = distance ?? this.distance
      ..firstName = firstName ?? this.firstName
      ..direction = direction ?? this.direction;
  }
}

InverseAddressRegeocodeAddressComponent $InverseAddressRegeocodeAddressComponentFromJson(
    Map<String, dynamic> json) {
  final InverseAddressRegeocodeAddressComponent inverseAddressRegeocodeAddressComponent = InverseAddressRegeocodeAddressComponent();
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    inverseAddressRegeocodeAddressComponent.city = city;
  }
  final String? province = jsonConvert.convert<String>(json['province']);
  if (province != null) {
    inverseAddressRegeocodeAddressComponent.province = province;
  }
  final String? adcode = jsonConvert.convert<String>(json['adcode']);
  if (adcode != null) {
    inverseAddressRegeocodeAddressComponent.adcode = adcode;
  }
  final String? district = jsonConvert.convert<String>(json['district']);
  if (district != null) {
    inverseAddressRegeocodeAddressComponent.district = district;
  }
  final String? towncode = jsonConvert.convert<String>(json['towncode']);
  if (towncode != null) {
    inverseAddressRegeocodeAddressComponent.towncode = towncode;
  }
  final InverseAddressRegeocodeAddressComponentStreetNumber? streetNumber = jsonConvert
      .convert<InverseAddressRegeocodeAddressComponentStreetNumber>(
      json['streetNumber']);
  if (streetNumber != null) {
    inverseAddressRegeocodeAddressComponent.streetNumber = streetNumber;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    inverseAddressRegeocodeAddressComponent.country = country;
  }
  final String? township = jsonConvert.convert<String>(json['township']);
  if (township != null) {
    inverseAddressRegeocodeAddressComponent.township = township;
  }
  final String? citycode = jsonConvert.convert<String>(json['citycode']);
  if (citycode != null) {
    inverseAddressRegeocodeAddressComponent.citycode = citycode;
  }
  return inverseAddressRegeocodeAddressComponent;
}

Map<String, dynamic> $InverseAddressRegeocodeAddressComponentToJson(
    InverseAddressRegeocodeAddressComponent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['city'] = entity.city;
  data['province'] = entity.province;
  data['adcode'] = entity.adcode;
  data['district'] = entity.district;
  data['towncode'] = entity.towncode;
  data['streetNumber'] = entity.streetNumber.toJson();
  data['country'] = entity.country;
  data['township'] = entity.township;
  data['citycode'] = entity.citycode;
  return data;
}

extension InverseAddressRegeocodeAddressComponentExtension on InverseAddressRegeocodeAddressComponent {
  InverseAddressRegeocodeAddressComponent copyWith({
    String? city,
    String? province,
    String? adcode,
    String? district,
    String? towncode,
    InverseAddressRegeocodeAddressComponentStreetNumber? streetNumber,
    String? country,
    String? township,
    String? citycode,
  }) {
    return InverseAddressRegeocodeAddressComponent()
      ..city = city ?? this.city
      ..province = province ?? this.province
      ..adcode = adcode ?? this.adcode
      ..district = district ?? this.district
      ..towncode = towncode ?? this.towncode
      ..streetNumber = streetNumber ?? this.streetNumber
      ..country = country ?? this.country
      ..township = township ?? this.township
      ..citycode = citycode ?? this.citycode;
  }
}

InverseAddressRegeocodeAddressComponentStreetNumber $InverseAddressRegeocodeAddressComponentStreetNumberFromJson(
    Map<String, dynamic> json) {
  final InverseAddressRegeocodeAddressComponentStreetNumber inverseAddressRegeocodeAddressComponentStreetNumber = InverseAddressRegeocodeAddressComponentStreetNumber();
  final String? number = jsonConvert.convert<String>(json['number']);
  if (number != null) {
    inverseAddressRegeocodeAddressComponentStreetNumber.number = number;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    inverseAddressRegeocodeAddressComponentStreetNumber.location = location;
  }
  final String? direction = jsonConvert.convert<String>(json['direction']);
  if (direction != null) {
    inverseAddressRegeocodeAddressComponentStreetNumber.direction = direction;
  }
  final String? distance = jsonConvert.convert<String>(json['distance']);
  if (distance != null) {
    inverseAddressRegeocodeAddressComponentStreetNumber.distance = distance;
  }
  final String? street = jsonConvert.convert<String>(json['street']);
  if (street != null) {
    inverseAddressRegeocodeAddressComponentStreetNumber.street = street;
  }
  return inverseAddressRegeocodeAddressComponentStreetNumber;
}

Map<String, dynamic> $InverseAddressRegeocodeAddressComponentStreetNumberToJson(
    InverseAddressRegeocodeAddressComponentStreetNumber entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['number'] = entity.number;
  data['location'] = entity.location;
  data['direction'] = entity.direction;
  data['distance'] = entity.distance;
  data['street'] = entity.street;
  return data;
}

extension InverseAddressRegeocodeAddressComponentStreetNumberExtension on InverseAddressRegeocodeAddressComponentStreetNumber {
  InverseAddressRegeocodeAddressComponentStreetNumber copyWith({
    String? number,
    String? location,
    String? direction,
    String? distance,
    String? street,
  }) {
    return InverseAddressRegeocodeAddressComponentStreetNumber()
      ..number = number ?? this.number
      ..location = location ?? this.location
      ..direction = direction ?? this.direction
      ..distance = distance ?? this.distance
      ..street = street ?? this.street;
  }
}

InverseAddressRegeocodeAois $InverseAddressRegeocodeAoisFromJson(
    Map<String, dynamic> json) {
  final InverseAddressRegeocodeAois inverseAddressRegeocodeAois = InverseAddressRegeocodeAois();
  final String? area = jsonConvert.convert<String>(json['area']);
  if (area != null) {
    inverseAddressRegeocodeAois.area = area;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    inverseAddressRegeocodeAois.type = type;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    inverseAddressRegeocodeAois.id = id;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    inverseAddressRegeocodeAois.location = location;
  }
  final String? adcode = jsonConvert.convert<String>(json['adcode']);
  if (adcode != null) {
    inverseAddressRegeocodeAois.adcode = adcode;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    inverseAddressRegeocodeAois.name = name;
  }
  final String? distance = jsonConvert.convert<String>(json['distance']);
  if (distance != null) {
    inverseAddressRegeocodeAois.distance = distance;
  }
  return inverseAddressRegeocodeAois;
}

Map<String, dynamic> $InverseAddressRegeocodeAoisToJson(
    InverseAddressRegeocodeAois entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['area'] = entity.area;
  data['type'] = entity.type;
  data['id'] = entity.id;
  data['location'] = entity.location;
  data['adcode'] = entity.adcode;
  data['name'] = entity.name;
  data['distance'] = entity.distance;
  return data;
}

extension InverseAddressRegeocodeAoisExtension on InverseAddressRegeocodeAois {
  InverseAddressRegeocodeAois copyWith({
    String? area,
    String? type,
    String? id,
    String? location,
    String? adcode,
    String? name,
    String? distance,
  }) {
    return InverseAddressRegeocodeAois()
      ..area = area ?? this.area
      ..type = type ?? this.type
      ..id = id ?? this.id
      ..location = location ?? this.location
      ..adcode = adcode ?? this.adcode
      ..name = name ?? this.name
      ..distance = distance ?? this.distance;
  }
}

InverseAddressRegeocodePois $InverseAddressRegeocodePoisFromJson(
    Map<String, dynamic> json) {
  final InverseAddressRegeocodePois inverseAddressRegeocodePois = InverseAddressRegeocodePois();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    inverseAddressRegeocodePois.id = id;
  }
  final String? direction = jsonConvert.convert<String>(json['direction']);
  if (direction != null) {
    inverseAddressRegeocodePois.direction = direction;
  }
  final dynamic businessarea = json['businessarea'];
  if (businessarea != null) {
    inverseAddressRegeocodePois.businessarea = businessarea;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    inverseAddressRegeocodePois.address = address;
  }
  final String? poiweight = jsonConvert.convert<String>(json['poiweight']);
  if (poiweight != null) {
    inverseAddressRegeocodePois.poiweight = poiweight;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    inverseAddressRegeocodePois.name = name;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    inverseAddressRegeocodePois.location = location;
  }
  final String? distance = jsonConvert.convert<String>(json['distance']);
  if (distance != null) {
    inverseAddressRegeocodePois.distance = distance;
  }
  final dynamic tel = json['tel'];
  if (tel != null) {
    inverseAddressRegeocodePois.tel = tel;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    inverseAddressRegeocodePois.type = type;
  }
  return inverseAddressRegeocodePois;
}

Map<String, dynamic> $InverseAddressRegeocodePoisToJson(
    InverseAddressRegeocodePois entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['direction'] = entity.direction;
  data['businessarea'] = entity.businessarea;
  data['address'] = entity.address;
  data['poiweight'] = entity.poiweight;
  data['name'] = entity.name;
  data['location'] = entity.location;
  data['distance'] = entity.distance;
  data['tel'] = entity.tel;
  data['type'] = entity.type;
  return data;
}

extension InverseAddressRegeocodePoisExtension on InverseAddressRegeocodePois {
  InverseAddressRegeocodePois copyWith({
    String? id,
    String? direction,
    dynamic businessarea,
    String? address,
    String? poiweight,
    String? name,
    String? location,
    String? distance,
    dynamic tel,
    String? type,
  }) {
    return InverseAddressRegeocodePois()
      ..id = id ?? this.id
      ..direction = direction ?? this.direction
      ..businessarea = businessarea ?? this.businessarea
      ..address = address ?? this.address
      ..poiweight = poiweight ?? this.poiweight
      ..name = name ?? this.name
      ..location = location ?? this.location
      ..distance = distance ?? this.distance
      ..tel = tel ?? this.tel
      ..type = type ?? this.type;
  }
}