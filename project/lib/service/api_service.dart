import 'package:dio/dio.dart';
import 'package:project/model/model.dart';
import 'package:project/model/user_model.dart';

class ReqresAPI {
  final dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api/'));

  // Dio addInterceptors(Dio dio) {
  //   return dio.interceptors.add(InterceptorsWrapper())
  // }

  ReqresAPI() {
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<ReqresData> fetchData() async {
    try {
      final response = await dio.get('users?page=1');
      if (response.statusCode == 200) {
        ReqresData data = ReqresData.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } on DioError {
      rethrow;
    }
  }

  Future<UserData> fetchDataById(int id) async {
    try {
      final response = await dio.get('users/$id');
      if (response.statusCode == 200) {
        UserData data = UserData.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } on DioError {
      rethrow;
    }
  }
}