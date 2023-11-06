import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:delivery_address/src/components/address_search_page.dart';
import 'package:delivery_address/src/components/address_selector_page.dart';
import 'package:delivery_address/src/components/button.dart';
import 'package:delivery_address/src/constants/constants.dart';
import 'package:delivery_address/src/utils/getCurrentPostion.dart';
import 'package:delivery_address/src/utils/network_util.dart';
import 'package:flutter/material.dart';

class Feature extends StatefulWidget {
  const Feature({Key? key}) : super(key: key);

  @override
  State<Feature> createState() => _FeatureState();
}

class _FeatureState extends State<Feature> {

  String curAddress = "";

  Districts? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: goToDistrictsSelector,
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)
                  ),
                  child: selectorDistrictsWidget(),
                ),
              ),
            ),
            Text("详细地址: ${selectedAddress?.detailAddress ?? ""}"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("当前地址: ${curAddress}"),
            ),
            const SizedBox(height: 10,),
            Button(
              "获取位置",
              width: 300,
              onPressed: getAddressDescription,
            )
          ],
        ),
      ),
    );
  }

  // 选择省 -> 街道的input
  Widget selectorDistrictsWidget() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AddressSelectorPage(
                    value: selectedAddress!,
                    onSelected: (value) {

                      setState(() {
                        selectedAddress = value;
                      });
                    }, maxHeight: 600,);
                }
            );
          },
          child: Text(spliceDistricts(selectedAddress)),
        ),
        IconButton(onPressed: () async {
          bool isStartPos = await checkPositionPermission();
          if (isStartPos) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddressSearchPage(onSelected: (districts) {
                setState(() {
                  selectedAddress = districts;
                });
              });
            }));
          }
        }, icon: Icon(Icons.add_reaction, color: Colors.pink,))
      ],
    );
  }

  Future<String> getAddressDescription() async {

    LatLng? latl = await getCurrentLocation();

    if (latl != null) {
      final response = await NetworkUtil.getInstance().request(
          'https://restapi.amap.com/v3/geocode/regeo?key=52c2a3f5b44f60f70cdd1dc6e1fcc894&location=${latl?.longitude},${latl?.latitude}&radius=1000&extensions=all&batch=false&roadlevel=0',
          method: Method.get
      );
      if (response != null) {
        setState(() {
          curAddress = response?.data?["formatted_address"];
        });
      }
    }

    return 'aaaa';
  }


  // 拼接字符串
  String spliceDistricts(Districts? districts) {
    if (districts == null) {
      return "";
    }
    return "${districts.province} ${districts.city} ${districts.district ?? ""} ${districts.street ?? ""}";
  }

  // 跳转选择省市区街道
  void goToDistrictsSelector() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          print("selectedAddressselectedAddress: $selectedAddress");
          return AddressSelectorPage(
            value: selectedAddress,
            onSelected: (value) {
              setState(() {
                selectedAddress = value;
              });
            }, maxHeight: 600,);
        }
    );
  }
}
