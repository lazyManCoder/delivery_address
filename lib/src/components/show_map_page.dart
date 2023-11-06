

import 'package:delivery_address/src/constants/constants.dart';
import 'package:delivery_address/src/utils/getCurrentPostion.dart';
import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class ConstConfig {
  ///配置您申请的apikey，在此处配置之后，可以在初始化[AMapWidget]时，通过`apiKey`属性设置
  ///
  ///注意：使用[AMapWidget]的`apiKey`属性设置的key的优先级高于通过Native配置key的优先级，
  ///使用[AMapWidget]的`apiKey`属性配置后Native配置的key将失效，请根据实际情况选择使用
  static const AMapApiKey amapApiKeys = AMapApiKey(
      androidKey: MapConfig.androidKey,
      iosKey: '您申请的iOS平台的key');

  ///高德隐私合规声明，这里只是示例，实际使用中请按照实际参数设置[AMapPrivacyStatement]的'hasContains''hasShow''hasAgree'这三个参数
  ///
  /// 注意：[AMapPrivacyStatement]的'hasContains''hasShow''hasAgree'这三个参数中有一个为false，高德SDK均不会工作，会造成地图白屏等现象
  ///
  /// 高德开发者合规指南请参考：https://lbs.amap.com/agreement/compliance
  ///
  /// 高德SDK合规使用方案请参考：https://lbs.amap.com/news/sdkhgsy
  static const AMapPrivacyStatement amapPrivacyStatement =
  AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);
}

class ShowMapPage extends StatefulWidget {
  const ShowMapPage({Key? key}) : super(key: key);

  @override
  State<ShowMapPage> createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<ShowMapPage> {

  late AMapController _mapController;

  CameraPosition? _initialCameraPosition;

  late final AMapWidget? map;

  LatLng? currentLatLng;

  @override
  void initState() {
    print("====init State");
    super.initState();
    getCurrentLocation().then((LatLng? location) {
      print("location: $location");
      if (location != null) {
        setState(() {
          _initialCameraPosition = CameraPosition(target: location, zoom: 15.0);
          currentLatLng = location;
          map = AMapWidget(
            privacyStatement: ConstConfig.amapPrivacyStatement,
            apiKey: ConstConfig.amapApiKeys,
            onMapCreated: onMapCreated,
            markers:  Set<Marker>.of([
               Marker(
                position: currentLatLng!,
                icon: BitmapDescriptor.defaultMarker, // Use the default marker icon
                infoWindow: InfoWindow(
                  title: '当前位置',
                ),
              ),
            ]),
            initialCameraPosition: _initialCameraPosition!,
          );
        });
      }
    });
  }


  @override
  void dispose() {
    _mapController.clearDisk();
    _mapController.disponse();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: _initialCameraPosition != null ? map : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void onMapCreated(AMapController controller) {
    print('onMapCreated');
    setState(() {
      _mapController = controller;
      getApprovalNumber();
    });
  }

  // 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String? mapContentApprovalNumber =
    await _mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String? satelliteImageApprovalNumber =
    await _mapController?.getSatelliteImageApprovalNumber();
  }

}
