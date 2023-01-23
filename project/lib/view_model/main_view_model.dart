import 'package:flutter/widgets.dart';
import 'package:project/model/model.dart';
import 'package:project/model/user_model.dart';
import 'package:project/service/api_service.dart';

class MainViewModel extends ChangeNotifier {
  ReqresData? _data;
  ReqresData? get data => _data;

  UserData? _userById;
  UserData? get userById => _userById;

  void getData() async {
    _data = await ReqresAPI().fetchData();
    notifyListeners();
  }

  void getUserById(int id) async {
    _userById = await ReqresAPI().fetchDataById(id);
    notifyListeners();
  }
}
