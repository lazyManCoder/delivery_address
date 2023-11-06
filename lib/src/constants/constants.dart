

import 'package:delivery_address/src/model/country_format_entity.dart';

class CountryInfo {
  final String name;
  final List<CountryInfo> child;

  CountryInfo({
    required this.name,
    required this.child,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    List<CountryInfo> children = (json['child'] as List)
        .map((childJson) => CountryInfo.fromJson(childJson))
        .toList();

    return CountryInfo(name: json['name'], child: children);
  }
}

class SelectAreaDataType {
  String name;
  List<CountryFormatEntity> data;

  String adcode;

  SelectAreaDataType({
    required this.name,
    required this.adcode,
    required this.data
  });
}


class Districts {
  String? detailAddress; // 详细地址
  final String? city; // 城市
  final String? province; // 省份
  final String? district; // 区域
  final String? street; // 街道

  Districts({
    this.detailAddress,
    this.city,
    this.province,
    this.district,
    this.street
  });
}

// AlphabeticalIndexPosition数据类型
class AlphabeticalIndexPositionData {
  final String name;
  final String? code; // 唯一标识
  final String? level; // 区域等级
  AlphabeticalIndexPositionData({ required this.name, this.code, this.level });
}


class MapConfig {
  static const String apiKey = '52c2a3f5b44f60f70cdd1dc6e1fcc894';

  static const String androidKey = "bab78cd6bfe369ac22b8b810ef08f854";
}
