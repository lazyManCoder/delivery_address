
import 'package:delivery_address/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';

typedef OnChanged = void Function(AlphabeticalIndexPositionData data);


class City {
  final List<String> cityNameList;
  final List<String> cityPinYinList;
  final List<AlphabeticalIndexPositionData> data;

  City({ required this.cityNameList, required this.cityPinYinList, required this.data });
}

class AlphabeticalIndexPosition extends StatefulWidget {
  /// 数据源
  final List<AlphabeticalIndexPositionData> data;

  final String? value;

  /// onChanged选中函数
  final OnChanged? onChanged;

  /// 选中的区域
  final String selectedArea;

  /// padding
  final double? padding;

  const AlphabeticalIndexPosition({
    Key? key,
    required this.data,
    this.onChanged,
    this.padding,
    this.selectedArea = "",
    this.value
  }) : super(key: key);

  @override
  State<AlphabeticalIndexPosition> createState() => _AlphabeticalIndexPositionState();
}

class _AlphabeticalIndexPositionState extends State<AlphabeticalIndexPosition> {
  late ScrollController _scrollController;
  String _highlightedLetter = '';
  City groupedAndSortedCities = City(cityNameList: [], cityPinYinList: [], data: []);


  @override
  void initState() {
    super.initState();

    groupedAndSortedCities = groupAndSortCities(widget.data);

    _scrollController = ScrollController();
    
    _scrollController.addListener(() {
      _updateHighlightedLetter();
    });
  }


  @override
  void didUpdateWidget(AlphabeticalIndexPosition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      groupedAndSortedCities = groupAndSortCities(widget.data);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: contentWidget(),),
            letterList()
          ],
        ),
      ),
    );
  }


  // 左侧内容区域
  Widget contentWidget() {
    // List<String> data = groupedAndSortedCities.cityNameList;

    List<AlphabeticalIndexPositionData> data = groupedAndSortedCities.data;

    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {

        AlphabeticalIndexPositionData curData = data[index];
        return GestureDetector(
          onTap: () {

            if (widget.onChanged != null) {
              widget.onChanged!(curData);
            }
          },
          child: Container(
            height: 40,
            child: Text(curData.name, style: TextStyle(color: widget.value != null && widget.value == curData.name ? Colors.pink : null),),
          ),
        );
      },
      itemCount: data.length,
    );
  }


  // 右侧字母索引区域
  Widget letterList() {
    List<String> letters = groupedAndSortedCities.cityPinYinList;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letters
            .asMap()
            .entries
            .map(
              (entry) {
            int index = entry.key;
            String letter = entry.value;

            bool isHighlighted = _highlightedLetter == letter || (index == 0 && _highlightedLetter.isEmpty);
            return GestureDetector(
              onTap: () => _updateContentArea(letter),
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Text(
                  letter,
                  style: TextStyle(
                    color: isHighlighted ? Colors.blue : Colors.black.withOpacity(0.6),
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        )
            .toList(),
      ),
    );
  }


  // 点击右侧首字母
  void _updateContentArea(String firstLetter) {
    // 获取指定首字母的城市在左侧列表中的位置
    int index = _getCityIndexForLetter(firstLetter);

    if (index != -1) {
      // 滚动到指定位置
      _scrollController.animateTo(index * 40.0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }

    setState(() {
      _highlightedLetter = firstLetter;
    });
  }


  // 在 _AlphabeticalIndexPositionState 中添加函数来获取指定首字母的城市在左侧列表中的位置
  int _getCityIndexForLetter(String letter) {
    // 获取左侧城市列表数据
    List<String> data = groupedAndSortedCities.data.map((e) => e.name).toList();

    // 寻找第一个以指定首字母开头的城市的索引
    int index = data.indexWhere((city) {
      String name = PinyinHelper.getShortPinyin(city);
      String firstLetter = name[0].toUpperCase();
      return firstLetter == letter;
    });

    return index;
  }

  // 左侧更新影响到右侧首字母列表
  void _updateHighlightedLetter() {
    double topOffset = _scrollController.position.pixels;

    List<AlphabeticalIndexPositionData> data = groupedAndSortedCities.data;
    List<String> alphabeticList = getFirstAlphabeticList(data.map((e) => e.name).toList());
    int topIndex = (topOffset / 40).floor();

    setState(() {
      _highlightedLetter = alphabeticList[topIndex];
    });
  }


  // 获取排好序的城市首字母大写列表
  List<String> getFirstAlphabeticList(List<String> data) {

    List<String> alphabeticList = [];
    for (var city in data) {
      String name = PinyinHelper.getShortPinyin(city);
      String firstLetter = name[0].toUpperCase();
      alphabeticList.add(firstLetter);
    }
    return alphabeticList;
  }

  City groupAndSortCities(List<AlphabeticalIndexPositionData> data) {
    // Sort the data list by city name
    data.sort((a, b) => a.name.compareTo(b.name));

    Map<String, List<String>> groupedCities = {};
    for (AlphabeticalIndexPositionData cityData in data) {
      String name = PinyinHelper.getShortPinyin(cityData.name);
      String firstLetter = name[0].toUpperCase();
      groupedCities[firstLetter] ??= [];
      groupedCities[firstLetter]!.add(cityData.name);
    }

    List<String> letters = groupedCities.keys.toList()..sort();

    // Sort the data based on the order of grouped letters
    List<AlphabeticalIndexPositionData> sortedData = [];
    for (String key in letters) {
      for (AlphabeticalIndexPositionData cityData in data) {
        String name = PinyinHelper.getShortPinyin(cityData.name);
        if (name[0].toUpperCase() == key) {
          sortedData.add(cityData);
          // resultArray.add(cityData.name);
        }
      }
    }

    return City(
      cityNameList: [],
      cityPinYinList: letters,
      data: sortedData,
    );
  }
}
