import 'dart:convert';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:delivery_address/src/components/selectbox_with_text_field.dart';
import 'package:delivery_address/src/components/show_map_page.dart';
import 'package:delivery_address/src/constants/constants.dart';
import 'package:delivery_address/src/model/around_placeV4_entity.dart';

import 'package:delivery_address/src/model/inverse_address_entity.dart';
import 'package:delivery_address/src/utils/getCurrentPostion.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class CurrentAddressData {
  final List<InverseAddressRegeocodePois> inverseAddresList;
  final String? currentAddress;
  final String? city; // 城市
  final String? province; // 省份
  final String? district; // 区域
  final String? street;

  CurrentAddressData({
    required this.inverseAddresList,
    this.currentAddress,
    this.city,
    this.province,
    this.district,
    this.street
  });
}


typedef OnSelected = void Function(Districts districts);

class AddressSearchPage extends StatefulWidget {
  final OnSelected onSelected;

  const AddressSearchPage({
    Key? key,
    required this.onSelected
  }) : super(key: key);

  @override
  State<AddressSearchPage> createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage> {

  late FocusNode _focusNode;

  bool focus = false;

  LatLng? localtion;

  List<AroundPlaceV4Pois> aroundData = [];
  CurrentAddressData? currentAddressData;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // 添加监听器，监听hasFocus属性的变化
    _focusNode.addListener(_onFocusChange);
    // 接口次数珍贵，测试使用
    getCurrentAddress();

    // 请求真实环境接口
    // getCurrentLocation().then((value) {
    //   getAddressFromLocation("${value?.longitude},${value?.latitude}", "1000").then((res) {
    //     setState(() {
    //       localtion = value;
    //       currentAddressData = res;
    //     });
    //   });
    // });
  }

  @override
  void dispose() {
    // 移除监听器，避免内存泄漏
    _focusNode.removeListener(_onFocusChange);
    if (_focusNode != null) {
      _focusNode.dispose();
    }

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          toolbarHeight: 44,
        automaticallyImplyLeading: false,
        leading: null,
        titleSpacing: 0,
        title: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: Color(0xFFDDDDDD)))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back_ios, size: 17,)),
                const Text("所在地区", style: TextStyle(fontSize: 18),),
                Container(width: 60,)
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: currentAddressData != null ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SelectBoxWithTextField(
                clickShowModalBottom: (bool isClickShowModalBottom) {
                  print("isClickShowModalBottom: $isClickShowModalBottom");
                  setState(() {
                    focus = isClickShowModalBottom;
                  });
                },
                value: currentAddressData?.city ?? "",
                focusNode: _focusNode,
                onChanged: (city, address) {
                  // getAroundPlaceData(city, address);
                },),
            ),
            focus || _focusNode.hasFocus ? focusSearchWidget() : noFocusSearchWidget()

          ],
        ) : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ));
  }

  Widget focusSearchWidget() {
    return  Container(
      width: double.infinity,
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            AroundPlaceV4Pois  curPlace = aroundData[index];

            return GestureDetector(
              onTap: () => onTabAroundAddress(curPlace.location, curPlace?.address),
              child: Container(
                constraints: const BoxConstraints(minHeight: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(curPlace.name ?? ""),
                    Text(curPlace?.address ?? "", style: const TextStyle(fontSize: 12, color: Color(0xFF999999)),)
                  ],
                ),
              ),
            );
          },
          itemCount: aroundData.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Color(0xFFF0F0F0),);
          },
        ),
      ),
    );
  }

  // search没有聚集的情况下
  Widget noFocusSearchWidget() {
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
          height: 220,
          child: ShowMapPage(),
        ),
        const SizedBox(height: 10,),
        Container(
          height: MediaQuery.of(context).size.height - 10 - 220 - 10 - 128,
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  // Container(
                  //   height: 80,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.4),
                  //           offset: const Offset(0.0, 1.0), // 阴影偏移量
                  //           blurRadius: 3.0, // 阴影模糊半径
                  //           spreadRadius: 1.0, // 阴影扩散半径
                  //         ),
                  //       ]
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text("当前地址"),
                  //         Text(currentAddressData?.currentAddress ?? "")
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10,),
                  Visibility(
                    visible: currentAddressData != null,
                    child: Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView.separated(
                          itemCount: currentAddressData!.inverseAddresList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(color: Color(0xFFF0F0F0),);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            InverseAddressRegeocodePois? item = currentAddressData?.inverseAddresList[index];

                            return GestureDetector(
                              onTap: () => onTabAddress(item?.address),
                              child: Container(
                                color: Colors.white,
                                constraints: const BoxConstraints(minHeight: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item?.name ?? ""),
                                    Text("${currentAddressData?.province}${currentAddressData?.city}${currentAddressData?.district}${item?.address}" ?? "", style: TextStyle(fontSize: 12, color: Color(0xFF999999)),)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        )
      ],
    );
  }


  // 选择周边搜索条件
  void onTabAroundAddress(String location, String? detailAddress) async {
    print("location:     $location");
    CurrentAddressData? curAddress = await getAddressFromLocation(location, "10");
    if (curAddress != null) {
      widget.onSelected(Districts(
        city: curAddress?.city,
        province: curAddress?.province,
        district: curAddress?.district,
        street: curAddress?.street,
        detailAddress: detailAddress
      ));
    }
    Navigator.pop(context);
  }

  // 处理点击选择具体地址  跳转到先前的地址
  void onTabAddress(String? detailAddress) {
    print("currentAddressData: $currentAddressData, ${currentAddressData?.street}");
    widget.onSelected(
      Districts(
        province: currentAddressData?.province,
        city: currentAddressData?.city,
        district: currentAddressData?.district,
        street: currentAddressData?.street,
        detailAddress: detailAddress
      )
    );

    Navigator.pop(context);
  }

  // 获取当前地址的数据 省市区街道数据
  void getCurrentAddress() async {
    final response = '''
    {
    "status": "1",
    "regeocode": {
        "roads": [
            {
                "id": "0571H50F021048600646",
                "location": "119.963,30.2715",
                "direction": "南",
                "name": "钱学森路",
                "distance": "51.2591"
            },
            {
                "id": "0571H50F021048614357",
                "location": "119.964,30.2701",
                "direction": "北",
                "name": "工业二路",
                "distance": "113.377"
            },
            {
                "id": "0571H50F0210482457",
                "location": "119.962,30.2709",
                "direction": "东",
                "name": "云联路",
                "distance": "134.043"
            }
        ],
        "roadinters": [
            {
                "second_name": "钱学森路",
                "first_id": "0571H50F0210482457",
                "second_id": "0571H50F021048600646",
                "location": "119.962153,30.271203",
                "distance": "136.449",
                "first_name": "云联路",
                "direction": "东"
            }
        ],
        "formatted_address": "浙江省杭州市余杭区余杭街道中资管金融科技研究院中国(杭州)人工智能小镇",
        "addressComponent": {
            "city": "杭州市",
            "province": "浙江省",
            "adcode": "330110",
            "district": "余杭区",
            "towncode": "330110012000",
            "streetNumber": {
                "number": "1820号",
                "location": "119.963472,30.270976",
                "direction": "西南",
                "distance": "15.0786",
                "street": "文一西路"
            },
            "country": "中国",
            "township": "余杭街道",
            "businessAreas": [
                []
            ],
            "building": {
                "name": [],
                "type": []
            },
            "neighborhood": {
                "name": [],
                "type": []
            },
            "citycode": "0571"
        },
        "aois": [
            {
                "area": "181838.837801",
                "type": "120100",
                "id": "B0FFI0K8FW",
                "location": "119.965839,30.270560",
                "adcode": "330110",
                "name": "中国(杭州)人工智能小镇",
                "distance": "0"
            }
        ],
        "pois": [
            {
                "id": "B0FFI0K8FW",
                "direction": "东",
                "businessarea": [],
                "address": "文一西路1818-2号",
                "poiweight": "0.22361",
                "name": "中国(杭州)人工智能小镇",
                "location": "119.965839,30.270560",
                "distance": "225.819",
                "tel": [],
                "type": "商务住宅;产业园区;产业园区"
            },
            {
                "id": "B0FFJFX9CP",
                "direction": "东",
                "businessarea": [],
                "address": "文一西路1818-2号中国(杭州)人工智能小镇",
                "poiweight": "0.17584",
                "name": "中国(杭州)人工智能小镇1号楼",
                "location": "119.965226,30.271572",
                "distance": "168.296",
                "tel": [],
                "type": "商务住宅;产业园区;产业园区"
            },
            {
                "id": "B0H065GJAC",
                "direction": "南",
                "businessarea": [],
                "address": "人工智能小镇11号楼802",
                "poiweight": "0.194703",
                "name": "中资管金融科技研究院",
                "location": "119.963553,30.270979",
                "distance": "11.7857",
                "tel": [],
                "type": "科教文化服务;科研机构;科研机构"
            },
            {
                "id": "B0H6379JM2",
                "direction": "北",
                "businessarea": [],
                "address": "余杭街道科技大道8-2号10幢103室",
                "poiweight": "0.170968",
                "name": "智片场(杭州)影视文化传媒有限公司",
                "location": "119.963472,30.271995",
                "distance": "101.697",
                "tel": "0571-89360115",
                "type": "科教文化服务;传媒机构;传媒机构"
            },
            {
                "id": "B0FFIG06M7",
                "direction": "东",
                "businessarea": [],
                "address": "文一西路1818-2号15幢3层",
                "poiweight": "0.156497",
                "name": "北航VR/AR创新研究院",
                "location": "119.964725,30.271063",
                "distance": "111.215",
                "tel": "17816056300",
                "type": "科教文化服务;科教文化场所;科教文化场所"
            }
        ]
    },
    "info": "OK",
    "infocode": "10000"
}
    ''';
    if (response != null) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(response);
        if (jsonData['regeocode']['pois'] != null && jsonData['regeocode']['pois'] is List) {
          List<dynamic> poisJson = jsonData['regeocode']['pois'];
          String formatted_address = jsonData['regeocode']['formatted_address'];
          String city = jsonData['regeocode']['addressComponent']["city"];
          String province = jsonData['regeocode']['addressComponent']["province"];
          String district = jsonData['regeocode']['addressComponent']["district"];
          String street = jsonData['regeocode']['addressComponent']["township"];

          List<InverseAddressRegeocodePois> poisList = poisJson.map((item) => InverseAddressRegeocodePois.fromJson(item)).toList();

          setState(() {
            currentAddressData = CurrentAddressData(
                currentAddress: formatted_address,
                inverseAddresList: poisList,
                city: city,
                province: province,
                district: district,
                street: street
            );
          });
        } else {
          print("无效的pois");
        }
      } catch (e) {
        print("json解析失败:  $e");
      }
    } else {
      print("Response is null.");
    }
  }


  // 地理编码，入参坐标 返回 详细的省市区街道信息
  Future<CurrentAddressData?> getAddressFromLocation(String location, String radius) async {
    print("locationlocationlocationL: $location");
    String apiUrl = "https://restapi.amap.com/v3/geocode/regeo";
    final queryParams = {
      'location': location,  // Example keywords
      'key': MapConfig.apiKey,
      'radius': radius,
      'extensions': "all",
      'roadlevel': "0"
    };

    final response = await dio.get(apiUrl, queryParameters: queryParams);

    if (response != null) {
      Map<String, dynamic> jsonData = response.data;
      try {
        List<dynamic> poisJson = [];

        List<InverseAddressRegeocodePois> poisList = [];
        String city = "";

        String address = jsonData['regeocode']['formatted_address'];
        String province = jsonData['regeocode']['addressComponent']["province"];

        if (jsonData['regeocode']['addressComponent']["city"] is List) {
          city = "${province.substring(0, province.length - 1)}城区";
        } else {
          city = jsonData['regeocode']['addressComponent']["city"];
        }

        String district = jsonData['regeocode']['addressComponent']["district"];
        String street = jsonData['regeocode']['addressComponent']["township"];

        if (jsonData['regeocode']['pois'] != null && jsonData['regeocode']['pois'] is List) {
          poisJson = jsonData['regeocode']['pois'] = jsonData['regeocode']['pois'];

          poisList = poisJson.map((item) => InverseAddressRegeocodePois.fromJson(item)).toList();
        }

        return CurrentAddressData(
            currentAddress: address,
            inverseAddresList: poisList,
            city: city,
            province: province,
            district: district,
            street: street
        );
      } catch (e) {
        print("error: $e");
      }
    }
  }

  void _onFocusChange() {
    // 当hasFocus属性变化时被调用
    setState(() {
      // 在这里处理UI更新逻辑
      print("_focusNode has focus: ${_focusNode.hasFocus}");
    });
  }

  // 获取附近的数据
  Future getAroundPlaceData(String city, String address) async {

    print("附近位置: $city   $address");
    String apiUrl = "https://restapi.amap.com/v3/place/text";
    final queryParams = {
      'keywords': address,  // Example keywords
      'key': MapConfig.apiKey,
      'city': city,
      'offset': 20,
      'page': 1
    };
    LatLng? latl = await getCurrentLocation();

    print("当前位置: $latl");


    // final response = await dio.get(apiUrl, queryParameters: queryParams);
    const response = '''
{
    "suggestion": {
        "keywords": [],
        "cities": []
    },
    "count": "608",
    "infocode": "10000",
    "pois": [
        {
            "parent": [],
            "address": "花园东路8号",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": []
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "商务住宅;住宅区;住宅小区",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/3ef502617c15440571ad9a3b9983f187"
                }
            ],
            "typecode": "120302",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": [],
            "adname": "海淀区",
            "name": "北极寺",
            "location": "116.372774,39.984875",
            "tel": "123",
            "shopid": [],
            "id": "B0FFFHGDTE"
        },
        {
            "parent": [],
            "address": "金蝉西路甲一号期D3区域8",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.3"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;专卖店;专营店",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/f305909182d7cd53a24a426e41d5f60e"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/e9f9585330267259b0d21d592c56ba40"
                }
            ],
            "typecode": "061200",
            "shopinfo": "1",
            "poiweight": [],
            "childtype": [],
            "adname": "朝阳区",
            "name": "山顶道北极星",
            "location": "116.504420,39.871439",
            "tel": "010-87557172",
            "shopid": [],
            "id": "B0FFKRVGFV"
        },
        {
            "parent": "B0FFG4VPTF",
            "address": "通惠苑2号楼101",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.0"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;家电电子卖场;家电电子卖场",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/e7f99c17554b48f7a8f5ce9fae1925cd"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/221a298333708bdd843a2c921705d086"
                }
            ],
            "typecode": "060300",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "202",
            "adname": "通州区",
            "name": "北极制冷",
            "location": "116.639428,39.909162",
            "tel": "15911093685",
            "shopid": [],
            "id": "B0FFHKWC95"
        },
        {
            "parent": "B0FFH99VVY",
            "address": "香河园路一号院12号楼下沉广场1层105铺北极星鲜花店",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.3"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;花鸟鱼虫市场;花卉市场",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/30d96e746742b900a6dad97037f10127"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/93c173f4f6fedde239ad4af1a5f2b6fa"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/a09e48e218ff15f8090ee306f83a26f6"
                }
            ],
            "typecode": "060501",
            "shopinfo": "1",
            "poiweight": [],
            "childtype": "320",
            "adname": "东城区",
            "name": "北极星鲜花(万国城MOMA店)",
            "location": "116.439884,39.948218",
            "tel": "13691484616",
            "shopid": [],
            "id": "B0I3UUOVB4"
        },
        {
            "parent": [],
            "address": "东城区",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": []
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "地名地址信息;交通地名;道路名",
            "photos": [],
            "typecode": "190301",
            "shopinfo": "2",
            "poiweight": [],
            "childtype": [],
            "adname": "东城区",
            "name": "北极阁胡同",
            "location": "116.421279,39.910370",
            "tel": [],
            "shopid": [],
            "id": "B0FFH6JHLU"
        },
        {
            "parent": "B000A838HT",
            "address": "鲁谷路98-10号",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.3"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;服装鞋帽皮具店;服装鞋帽皮具店",
            "photos": [
                {
                    "title": [],
                    "url": "http://aos-cdn-image.amap.com/sns/ugccomment/83d81c5d-d58e-4acc-aab5-c18ab81c1df0.jpg"
                }
            ],
            "typecode": "061100",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "320",
            "adname": "石景山区",
            "name": "北极狐(鲁谷路店)",
            "location": "116.239263,39.903524",
            "tel": [],
            "shopid": [],
            "id": "B0FFJO6Q1V"
        },
        {
            "parent": "B000A83LNO",
            "address": "东长安街1号北京东方新天地LG层",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.3"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;服装鞋帽皮具店;品牌箱包店|购物服务;体育用品店;户外用品",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/fe4d26734cfe471d1366440793d70606"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/5f2d8e5e7175d344e9290d5b0ecf4482"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/3577cde12df9331a739e54104e2174f8"
                }
            ],
            "typecode": "061104|060907",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "202",
            "adname": "东城区",
            "name": "北极狐(北京东方新天地店)",
            "location": "116.414352,39.909377",
            "tel": "010-85188947",
            "shopid": [],
            "id": "B0FFIY23ZU"
        },
        {
            "parent": "B0FFGLCRAG",
            "address": "南四环西路76号花乡奥莱村8号楼一层",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.4"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;服装鞋帽皮具店;品牌服装店",
            "photos": [
                {
                    "title": [],
                    "url": "https://aos-comment.amap.com/B0H6LCE3E5/headerImg/93546a0fe8ad3000fac1b256b80861e3_2048_2048_80.jpg"
                },
                {
                    "title": [],
                    "url": "https://aos-comment.amap.com/B0H6LCE3E5/headerImg/68177ff3850447533dad2462ec39c9cd_2048_2048_80.jpg"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/2c7194329017d4638b7e2733f3b84bee"
                }
            ],
            "typecode": "061101",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "201",
            "adname": "丰台区",
            "name": "北极狐(花乡奥莱村店)",
            "location": "116.323721,39.826306",
            "tel": "010-83715317",
            "shopid": [],
            "id": "B0H6LCE3E5"
        },
        {
            "parent": "B000A8W0JV",
            "address": "酒仙桥路18号颐堤港L3层L3-32(将台地铁站出入口旁)",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.1"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;体育用品店;体育用品店",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/51456f0fd33cd27059a568c3db235591"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/a5538fc4a78578706c9cfbc426b4a79b"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/f217fc32893dbe3336c8d01fe8d5629c"
                }
            ],
            "typecode": "060900",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "201",
            "adname": "朝阳区",
            "name": "北极狐(颐堤港店)",
            "location": "116.491219,39.970083",
            "tel": [],
            "shopid": [],
            "id": "B0FFM5O0VE"
        },
        {
            "parent": [],
            "address": "东城区",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": []
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "地名地址信息;交通地名;道路名",
            "photos": [],
            "typecode": "190301",
            "shopinfo": "2",
            "poiweight": [],
            "childtype": [],
            "adname": "东城区",
            "name": "北极阁四条",
            "location": "116.421926,39.911169",
            "tel": [],
            "shopid": [],
            "id": "B0FFH6JG5X"
        },
        {
            "parent": "B000A88EG4",
            "address": "三里屯路19号三里屯太古里南区LG层SLGK9",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.4"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;服装鞋帽皮具店;品牌箱包店",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/a7c8f898837d4bc2eca85261447128e0"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/936e3bf1ed390bb755ef293acfa50a1b"
                }
            ],
            "typecode": "061104",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "201",
            "adname": "朝阳区",
            "name": "北极狐(三里屯太古里南区店)",
            "location": "116.454312,39.935506",
            "tel": [],
            "shopid": [],
            "id": "B0FFIY71TV"
        },
        {
            "parent": "B000A7COFT",
            "address": "花园路2号翠微百货牡丹园店三层",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.4"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;服装鞋帽皮具店;品牌服装店",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/0ecc19f410a3294922aec3fb58fc0215"
                }
            ],
            "typecode": "061101",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "201",
            "adname": "海淀区",
            "name": "北极狐(翠微百货牡丹园店)",
            "location": "116.367440,39.977288",
            "tel": [],
            "shopid": [],
            "id": "B0FFHPUOJJ"
        },
        {
            "parent": [],
            "address": "城外诚家居广场(成寿寺路)饰品中心二层B通道19号",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "3.6"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;专卖店;钟表店",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/1bae4296af67cb1bff03f7f43e15f497"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/2d78fe422fc7469c7e910c2bf17204e0"
                }
            ],
            "typecode": "061203",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": [],
            "adname": "朝阳区",
            "name": "北极星授权专卖",
            "location": "116.453302,39.836585",
            "tel": "13811098700",
            "shopid": [],
            "id": "B0GK7YXLT6"
        },
        {
            "parent": [],
            "address": "东城区",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": []
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "地名地址信息;交通地名;道路名|地名地址信息;交通地名;路口名",
            "photos": [],
            "typecode": "190301|190302",
            "shopinfo": "2",
            "poiweight": [],
            "childtype": [],
            "adname": "东城区",
            "name": "北极阁三条",
            "location": "116.420123,39.910666",
            "tel": [],
            "shopid": [],
            "id": "B000A82WKS"
        },
        {
            "parent": "B0FFF3J47S",
            "address": "东四环南路9号北京燕莎奥特莱斯购物中心2F层",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.2"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;体育用品店;户外用品",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/e3d1a24342f3028c7a138f24c9917cfa"
                }
            ],
            "typecode": "060907",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "202",
            "adname": "朝阳区",
            "name": "北极狐(燕莎奥特莱斯购物中心北京店)",
            "location": "116.488113,39.878271",
            "tel": [],
            "shopid": [],
            "id": "B0IAV65Y7T"
        },
        {
            "parent": [],
            "address": "鲁谷东街8号玉泉电器三层C02",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "3.6"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;家电电子卖场;数码电子",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/1646b9d914658a9d0617560037a2491d"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/d3372a8f9c1b0f5200fd9acf048c77e3"
                }
            ],
            "typecode": "060306",
            "shopinfo": "1",
            "poiweight": [],
            "childtype": [],
            "adname": "石景山区",
            "name": "北极声专卖店",
            "location": "116.236571,39.903180",
            "tel": "13901362463",
            "shopid": [],
            "id": "B0IA7Z92FU"
        },
        {
            "parent": "B0FFKU0AXX",
            "address": "复兴路33号翠微百货(公主坟地铁站A西北口步行420米)",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "3.5"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;体育用品店;户外用品",
            "photos": [],
            "typecode": "060907",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "202",
            "adname": "海淀区",
            "name": "北极狐(翠微百货翠微店)",
            "location": "116.305669,39.908171",
            "tel": [],
            "shopid": [],
            "id": "B0FFJKC9V8"
        },
        {
            "parent": "B000A7AFF1",
            "address": "北三环西路38号双安4层",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.1"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;服装鞋帽皮具店;品牌服装店",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/c442326853dc5ec673d072b0e29baa5a"
                },
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/a3157ef52423172a536911f818bc67b1"
                }
            ],
            "typecode": "061101",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "201",
            "adname": "海淀区",
            "name": "北极狐(双安商场店)",
            "location": "116.325678,39.966431",
            "tel": "010-62167556",
            "shopid": [],
            "id": "B000ABC1NA"
        },
        {
            "parent": [],
            "address": "东城区",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": []
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "地名地址信息;交通地名;道路名",
            "photos": [],
            "typecode": "190301",
            "shopinfo": "2",
            "poiweight": [],
            "childtype": [],
            "adname": "东城区",
            "name": "北极阁路",
            "location": "116.420458,39.909772",
            "tel": [],
            "shopid": [],
            "id": "BZDBPW02JJ"
        },
        {
            "parent": "B000A384A3",
            "address": "中关村大街40号当代商城5层",
            "distance": [],
            "pname": "北京市",
            "importance": [],
            "biz_ext": {
                "cost": [],
                "rating": "4.0"
            },
            "biz_type": [],
            "cityname": "北京市",
            "type": "购物服务;服装鞋帽皮具店;品牌服装店",
            "photos": [
                {
                    "title": [],
                    "url": "http://store.is.autonavi.com/showpic/15fbe768b7ad74cdf5e13a599c1d0d10"
                }
            ],
            "typecode": "061101",
            "shopinfo": "0",
            "poiweight": [],
            "childtype": "201",
            "adname": "海淀区",
            "name": "北极狐专柜(当代商城中关村店)",
            "location": "116.321114,39.970691",
            "tel": [],
            "shopid": [],
            "id": "B0FFHQA08O"
        }
    ],
    "status": "1",
    "info": "OK"
}
''';
    if (response != null) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(response);
        if (jsonData['pois'] != null && jsonData['pois'] is List) {
          List<dynamic> poisJson = jsonData['pois'];

          List<AroundPlaceV4Pois> poisList = poisJson.map((item) => AroundPlaceV4Pois.fromJson(item)).toList();

          setState(() {
            aroundData = poisList;
          });
        } else {
          print("Invalid 'pois' data in the response.");
        }
      } catch (e) {
        print("json解析失败:  $e");
      }
    } else {
      print("Response is null.");
    }
  }
}
