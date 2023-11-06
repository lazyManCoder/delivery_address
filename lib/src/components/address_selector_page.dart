
import 'package:delivery_address/src/components/alphabetical_index_postion.dart';
import 'package:delivery_address/src/constants/constants.dart';
import 'package:delivery_address/src/model/country_format_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dio/dio.dart';

final dio = Dio();

class City {
  final String name;

  City(this.name);
}

typedef OnSelected = void Function(Districts value);

Map<String, List<City>> groupCities(List<City> cities) {
  Map<String, List<City>> groupedCities = {};

  for (City city in cities) {
    String name = city.name;
    String firstLetter = name[0].toUpperCase();
    groupedCities[firstLetter] ??= [];
    groupedCities[firstLetter]!.add(city);
  }

  // 按字母顺序排序每个城市组
  groupedCities.forEach((key, value) {
    value.sort((a, b) => a.name.compareTo(b.name));
  });

  return groupedCities;
}

class AddressSelectorPage extends StatefulWidget {

  /// 最大高度
  final double? maxHeight;

  /// 回调
  final OnSelected onSelected;

  /// 回显设置值
  final Districts? value;

  const AddressSelectorPage({
    Key? key,
    required this.onSelected,
    this.value,
    this.maxHeight
  }) : super(key: key);

  @override
  State<AddressSelectorPage> createState() => _AddressSelectorPageState();
}

class _AddressSelectorPageState extends State<AddressSelectorPage> with SingleTickerProviderStateMixin {
  Districts? collectAddress;

  List<Widget> hotCityList = [
    Text("北京"),
    Text("上海"),
    Text("广州"),
    Text("深圳"),
  ];

  List<CountryInfo> countryInfoList = [];

  List<SelectAreaDataType> selectedArea = [
    SelectAreaDataType(name: "请选择", data: [], adcode: ""),
    SelectAreaDataType(name: "", data: [], adcode: ""),
    SelectAreaDataType(name: "", data: [], adcode: ""),
    SelectAreaDataType(name: "", data: [], adcode: ""),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: selectedArea.length, vsync: this);
    loadJsonData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
      ),
      height: widget.maxHeight ?? double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Container(
            child: const Text("所在地区", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
          ),
          Expanded(child: selectedArea[0].data.isNotEmpty ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: DefaultTabController(
              length: selectedArea.length,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 10,
                  bottom: TabBar(
                    labelStyle: const TextStyle(fontSize: 12),
                    labelColor: const Color(0xFFE85656),
                    unselectedLabelColor: const Color(0xFF030303),
                    indicatorColor: const Color(0xFFE85656),
                    onTap: onTap,
                    controller: _tabController,
                    tabs: selectedArea.map((e) => Tab(child: Container(
                      child: Text(e.name),),)).toList(),
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: selectedArea.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return Center(
                      child: AlphabeticalIndexPosition(
                        value: item.name,
                        data: item.data.map((e) => AlphabeticalIndexPositionData(name: e.name, code: e.adcode, level: e.level)).toList(),
                        onChanged: (data) => selectorArea(data, index),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ) : const Center(child: CircularProgressIndicator(),))
        ],
      ),
    );
  }

  Future<String> loadJsonFromAssets(String path) async {
    return await rootBundle.loadString(path);
  }


  // 加载json数据
  Future<void> loadJsonData() async {
    List<CountryFormatEntity> countryInfo = await getAllCountryInfo("100000");

    // 处理回显数据
    dealDistrict(widget.value, countryInfo);

    // 第一次进入的时候进行更新
    if (widget.value?.province == null) {
      setState(() {
        selectedArea[0].data = countryInfo;
      });
    }

  }

  // 获取当前行政区域
  Future<List<CountryFormatEntity>> getAllCountryInfo(String adCode) async {
    String apiUrl = "https://restapi.amap.com/v3/config/district";
    final queryParams = {
      'keywords': adCode,  // 查询所有的省份
      'key': MapConfig.apiKey,
      'subdistrict': 1,
      'extensions': "base",
    };

    final response = await dio.get(apiUrl, queryParameters: queryParams);

    if (response != null) {
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> json2Map = jsonData["districts"][0]["districts"];
      List<CountryFormatEntity> countryInfo = json2Map
          .map((json) => CountryFormatEntity.fromJson(json))
          .toList();
      return countryInfo;
    }
    return [];
  }


  // 处理有value存在的情况
  void dealDistrict(Districts? value, List<CountryFormatEntity> countryInfoList) async {
    String? province = collectAddress?.province;
    String? city = collectAddress?.city;
    String? districts = collectAddress?.district;
    String? street = collectAddress?.street;

    print("============province: ${value?.province}, city: ${value?.city}, districts: ${value?.district}, street: ${value?.street}");
    if (value != null && value.province != null) {
      province = value.province!;
      selectedArea[0].name = value.province!;
      selectedArea[0].data = countryInfoList;
      selectedArea[1].name = "请选择";
      // List<CountryFormatEntity> cityData = countryInfoList.where((e) => e.name == value.province).first.districts;
      List<CountryFormatEntity> cityData = await getAllCountryInfo(province);

      if (value.city != null) {
        city = value.city!;
        selectedArea[1].name = value.city!;
        selectedArea[1].data = cityData;

        // List<CountryFormatEntity> districtData = cityData.where((e) => e.name == value.city).first.districts;
        List<CountryFormatEntity> districtData = await getAllCountryInfo(city);
        if (districtData.isNotEmpty) {
          selectedArea[2].name = "请选择";
        }

        print("value.district == null: ${value.district == null}");
        if (value.district == null || value.district!.isEmpty) {
          _tabController.animateTo(1);
          districts = "";
        }

        if (value.district != null && value.district!.isNotEmpty) {
          districts = value.district!;
          selectedArea[2].name = value.district!;
          selectedArea[2].data = districtData;
          selectedArea[3].name = "请选择";

          List<CountryFormatEntity> streetData = await getAllCountryInfo(districts);
          // List<CountryFormatEntity> streetData = districtData.where((e) => e.name == value.district).first.districts;

          if (value.street == null || value.street!.isEmpty) {
            street = "";
            _tabController.animateTo(2);
          }

          print("streetData: $streetData");
          if (value.street != null && value.street!.isNotEmpty) {
            street = value.street!;
            selectedArea[3].name = value.street!;
            selectedArea[3].data = streetData;
            _tabController.animateTo(3);
          } else {
            selectedArea[3].data = streetData;
          }
        }
      }
      collectAddress = Districts(province: province, city: city, district: districts, street: street);
      setState(() {

      });
    }
  }

  void onTap(int index) {
    print("index is $index");
    if (index == 1) {
      // Your condition check logic
      bool canNavigate = false; // Change this based on your condition
      if (!canNavigate) {
        // If condition is not met, prevent changing the tab
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You cannot navigate to this tab.'),
        ));
        return;
      }
    }
    print("点击");
    _tabController.animateTo(index);
  }

  // 选择省市区街道
  void selectorArea(AlphabeticalIndexPositionData data, int index) async {
    String? province = collectAddress?.province;
    String? city = collectAddress?.city;
    String? districts = collectAddress?.district;
    String? street = collectAddress?.street;
    String code = data?.code ?? "";
    String value = data.name;
    String level = data?.level ?? "";

    print("选择省市街道: $code $value");
    switch(index) {
      case 0:
        province = value;
        break;
      case 1:
        city = value;
        break;
      case 2:
        districts = value;
        break;
      case 3:
        street = value;
        break;
    }

    // 重新选择之前地址的时候，进行清空后续的变量
    for (int i = 0; i < selectedArea.length; i++) {
      if (i > index) {
        selectedArea[i].name = "";
        selectedArea[i].data = [];


        switch(i) {
          case 1:
            city = "";
            break;
          case 2:
            districts = "";
            break;
          case 3:
            street = "";
        }

      }
    }

    print("district = $districts, street = $street");

    collectAddress = Districts(province: province, city: city, district: districts, street: street);

    // // 下一个行政区的管辖区域
    List<CountryFormatEntity> nextData = await getAllCountryInfo(code);
    // List<CountryFormatEntity> nextData = countryInfoList.where((e) => e.name == value).first.districts;


    setState(() {
      selectedArea[index].name = value;
      if (index < 3) {
        selectedArea[index + 1].name = "请选择";
        selectedArea[index + 1].data = nextData;
        _tabController.animateTo(index + 1);
      }
    });


    // 关闭选项
    if (nextData.isEmpty || level == "street") {
      widget.onSelected(collectAddress!);
      Navigator.pop(context);
    }
  }
}


