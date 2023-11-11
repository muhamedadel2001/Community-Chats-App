import 'package:dio/dio.dart';

class MyDio {
  static Dio? dio;
  static dioInit() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  static Future<Response> getData(
      {required String endPoint, Map<String, dynamic>? query}) async {
    dio!.options.headers = {
      'Authorization': "Bearer 85|QwxPN8ujsSOs4l6sRM5Ci2vQABeMYi6Krp9nhNar"
    };
    return await dio!.get(
      endPoint,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
  {required String endPoint,
     Map<String, dynamic> ?data}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAo9v55HE:APA91bG_Jzhwwv3PsYz_6h_yDYmVELVPyo8WmAgRcAfCwnZr5Ralg8hgkS0BLgbqTZiZmS2vzXu64by75Uaig8kCz2oKxFdPlZFA7hD67dgYqRzFvjO-i6tHXB7IwnFigT8rQL2ZOnjp'
    };
    return await dio!.post(endPoint,data:data,
       );
  }
}