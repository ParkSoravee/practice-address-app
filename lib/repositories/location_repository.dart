import 'dart:convert';

import 'package:practices/config/constants.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class LocationRepository {
  Future<List<Province>> get getProvince async {
    try {
      final res = await http.get(Uri.parse(provinceEndpoint));
      final resList = List.from(jsonDecode(res.body) as List);
      final List<Province> provinceList = [];

      for (var x in resList) {
        provinceList.add(
          Province(
            id: x['id'].toString(),
            name: x['name_th'],
          ),
        );
      }
      return provinceList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Amphure>> getAmphureByProvinceId(String provinceId) async {
    try {
      final res = await http.get(Uri.parse(amphureEndpoint));
      final resList = List.from(jsonDecode(res.body) as List);
      final List<Amphure> amphureList = [];
      for (var x in resList) {
        amphureList.add(
          Amphure(
            id: x['id'].toString(),
            name: x['name_th'],
            provinceId: x['province_id'].toString(),
          ),
        );
      }
      return amphureList
          .where((element) => element.provinceId == provinceId)
          .toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Tambon>> getTambonByAmphureId(String amphureId) async {
    try {
      final res = await http.get(Uri.parse(tambonEndpoint));
      final resList = List.from(jsonDecode(res.body) as List);
      final List<Tambon> tambonList = [];

      for (var x in resList) {
        tambonList.add(
          Tambon(
            id: x['id'].toString(),
            name: x['name_th'],
            amphureId: x['amphure_id'].toString(),
            code: x['zip_code'].toString(),
          ),
        );
      }
      return tambonList
          .where((element) => element.amphureId == amphureId)
          .toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
