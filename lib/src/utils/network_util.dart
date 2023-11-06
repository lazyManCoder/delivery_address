import 'dart:convert';

import 'package:delivery_address/src/utils/sp_util.dart';
import 'package:dio/dio.dart';
// import 'toast.dart';
import 'dart:convert' as cvt;
import 'package:flutter/material.dart';
// import 'package:assembler_app/main.dart';
import 'package:another_flushbar/flushbar.dart';

enum Method {
  get,
  post,
  postFile
}

class NetworkUtil {
  Dio? _dio;

  static String baseURL = '';

  String? _token;

  // 外界无法实例化
  NetworkUtil._();

  // 实例化Http
  factory NetworkUtil() => _instance;

  // 初始化配置
  static final NetworkUtil _instance = NetworkUtil._internal();

  ///通用全局单例，第一次使用时初始化
  NetworkUtil._internal() {
    _dio ??= Dio();
    _dio?.options.baseUrl = baseURL;
    _dio?.options.connectTimeout = const Duration(seconds: 10);
    _dio?.options.contentType = Headers.jsonContentType;
    // 添加拦截器
    _setupInterceptors();
  }


  // 添加 Dio 拦截器
  void _setupInterceptors() {
    _dio?.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, handler) {
        if (error.response?.statusCode == 401) {
          // _handleUnauthorizedError();
        }
        return handler.next(error);
      },
    ));
  }

  // void _handleUnauthorizedError() {
  //   // 处理未授权错误
  //   navigatorKey.currentState?.pushNamed("/login");
  //
  //   // 退出清空操作
  //   SpUtil.getInstance().remove("tok");
  //   _token = null;
  //
  //   BuildContext? context = navigatorKey?.currentState?.overlay?.context;
  //
  //   if (context != null) {
  //      Flushbar(
  //       message: "登录过期，请重新登录",
  //       duration: Duration(seconds: 3),
  //       flushbarPosition: FlushbarPosition.TOP,
  //       backgroundColor: Color(0xFFE85656),
  //       // backgroundColor: Color(0xFFFF6900),
  //     )..show(context);
  //   }
  // }



  /// 暴露的实例
  /// #### [base_url] String|选填|基础路径
  static NetworkUtil getInstance() => _instance;

  /// ### 通用的POST请求
  /// #### [api] String|必填|请求路径
  /// #### [params] String|选填|请求的参数
  Future<HttpResponse?> _post(api,
      {required Map<String, dynamic> params, String? contentType = Headers.jsonContentType}) async {
    try {
      Response? res = await _dio?.post(api, data: params, options: Options(contentType: contentType));
      return _analysis(res);
    } catch (e) {
      if (e is DioError) {
        if (e.error != null) {
          throw StateError(e.error!.toString());
        }
      }
      if (e is StateError) {
        throw StateError(e.message);
      }
      return null;
    }
  }

  ///通用的GET请求
  /// * [api] 必填|请求路径（注：）
  /// * [params] 选填|请求的参数
  Future<HttpResponse?> _get(api,
      {required Map<String, dynamic> params, bool? otherApi}) async {
    Response? res = await _dio?.get(api, queryParameters: params);

    return _analysis(res);
  }


  /// 上传文件内容
  Future<HttpResponse?> _postFile(api,
      {required FormData data}) async {
    try {
      Response? res = await _dio?.post(api, data: data, options: Options(contentType: 'multipart/form-data'));
      return _analysis(res);
    } catch (e) {
      if (e is DioError) {
        if (e.error != null) {
          throw StateError(e.error!.toString());
        }
      }

      if (e is StateError) {
        throw StateError(e.message);
      }
      return null;
    }
  }

  Future<HttpResponse?> request(api,
      {Map<String, dynamic> params = const {},
        FormData? data,
        Method method = Method.post,
        String? contentType = Headers.jsonContentType,
        bool? otherApi = false
      }) async {

    if (null == _token || _token!.isEmpty) {
      _token = await SpUtil.getInstance().getString('tok');
      _dio?.options.headers['Authorization'] = _token;
    }

    switch(method) {
      case Method.post:
        return _post(api, params: params, contentType: contentType);

      case Method.get:
        return _get(api, params: params, otherApi: otherApi);

      case Method.postFile:
        return _postFile(api, data: data!);
    }
  }

  HttpResponse? handleAmapPoiData(List<dynamic> poiList, String formatted_address) {
    // 处理 poiList 数据并返回高德地图 SDK 需要的格式
    // 根据高德地图 SDK 要求的数据格式构造 HttpResponse 对象
    // ...

    // 示例：构造一个 HttpResponse 对象
    return HttpResponse.fromJson({
      "code": "00000000",
      "msg": "成功",
      "data": {
        "poiList": poiList,
        "formatted_address": formatted_address
      },
    });
  }

  // 处理第三方数据
  Future<void> _analysisOtherdata(Response? res) async {
    if (res == null) {
      print('Response is null.');
      return;
    }

    if (res.statusCode != 200) {
      print('Error: HTTP ${res.statusCode}');
      return;
    }

    try {
      // Parse JSON
      Map<String, dynamic> jsonData = jsonDecode(res.data);

      // Now you have the parsed JSON data, you can access its properties and process them
      String? name = jsonData['name'];
      String? address = jsonData['address'];

      // Process the data as needed
      print('Name: $name');
      print('Address: $address');
    } catch (e) {
      print('Error parsing JSON: $e');
    }
  }

  // 分析请求结果
  HttpResponse? _analysis(Response? res) {

    print("resssss: $res");
    if (res?.statusCode == 200 || res?.statusCode == 201) {
      Map<String, dynamic>? responseData = res?.data;

      if (responseData?['status'] == "1") {
        // 提取高德地图 SDK 需要的数据
        List<dynamic> poiList = [];
        if (responseData?["pois"] != null) {
          poiList = responseData?["pois"];
        }

        if (responseData?['regeocode']['pois'] != null) {
          poiList = responseData?['regeocode']['pois'];
        }

        String formatted_address = "";

        if (responseData?['regeocode']["formatted_address"] != null) {
          formatted_address = responseData?['regeocode']["formatted_address"];
        }


        print("poiListpoiList: $poiList");


        // 处理 poiList 数据并返回
        // 返回的数据格式需要符合高德地图 SDK 要求的格式
        return handleAmapPoiData(poiList, formatted_address);
      }

      // 请求完成并无错误
      if (res?.data['code'] == '00000000') {
        if (res?.data is Map) {
          return HttpResponse.fromJson(res?.data);
        } else {
          return cvt.jsonDecode(res?.data?.toString() ?? '');
        }
      } else if (res?.data['code'] == '88888888') {
        throw StateError(res?.data['code']);
      } else {
        throw StateError(res?.data['message']);
      }
    } else {
      throw StateError('获取数据失败，${ErrorType.handleHttpError(res?.statusCode)}');
    }
  }

  void handleError(BuildContext context, dynamic error) {
    String errString = error.toString();
    if (errString.startsWith('Bad state: ')) {
      errString = errString.split("Bad state: ")[1];
    }

    //token失效的处理
    if (errString == '88888888') {
      // Toast.showToast(context, msg: 'token失效，需要重新登录', showType: ShowType.error);

      Navigator.pushNamed(context, '/login');


    } else {
      // Toast.showToast(context, msg: errString, showType: ShowType.error);
    }
  }
}

/// 返回结果内容修饰
class HttpResponse {
  String? _code;

  String? _msg;

  dynamic _data;

  String? _type;

  bool get isSuccess => _code == "00000000";

  HttpResponse.fromJson(Map result) {
    _code = result["code"];
    _msg = result["message"];
    _data = result["data"];
    _type = result["type"];
  }

  String? get code => _code;

  String? get msg => _msg;

  dynamic get data => _data;

  String? get type => _type;

  @override
  String toString() {
    return "HttpResponse{code: $code, msg: $msg, "
        "data: $data, type: $type}";
  }
}

/// 逻辑错误描述
class ErrorType {
  // 处理 Dio 异常
  static String dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.sendTimeout:
        return "发送超时，请稍后重试";
      case DioErrorType.receiveTimeout:
        return "服务器异常，请稍后重试";
      case DioErrorType.badResponse:
        return "服务器异常，请稍后重试";
      case DioErrorType.cancel:
        return "请求已被取消，请重新请求";
      default:
        return "未知错误";
    }
  }

  // 处理 Http 错误码
  static String handleHttpError(int? errorCode) {
    String message;
    switch (errorCode) {
      case 400:
        message = '请求语法错误';
        break;
      case 401:
        message = '未授权，请登录';
        break;
      case 403:
        message = '拒绝访问';
        break;
      case 404:
        message = '请求出错';
        break;
      case 408:
        message = '请求超时';
        break;
      case 500:
        message = '服务器异常';
        break;
      case 501:
        message = '服务未实现';
        break;
      case 502:
        message = '网关错误';
        break;
      case 503:
        message = '服务不可用';
        break;
      case 504:
        message = '网关超时';
        break;
      case 505:
        message = 'HTTP版本不受支持';
        break;
      default:
        message = '请求失败，错误码：$errorCode';
    }

    return message;
  }
}
