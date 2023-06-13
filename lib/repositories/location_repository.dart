import 'dart:convert';

import 'package:practices/config/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class LocationRepository {
  Future<List<Province>> searchProvince(String searchWord) async {
    final GraphQLClient client = GraphQLClient(
        link: HttpLink('https://better-prong-railway.glitch.me/province'),
        cache: GraphQLCache());
    const String query = """
        query(\$searchWord: String) {
          province(name: \$searchWord) {
            id
            name_th
          }
        }
      """;
    final QueryResult result =
        await client.query(QueryOptions(document: gql(query), variables: {
      "searchWord": searchWord,
    }));

    if (result.hasException) {
      throw result.exception!;
    }
    final data = result.data!['province'] as List;
    final List<Province> provinceList = [];

    for (var x in data) {
      provinceList.add(
        Province(
          id: x['id'].toString(),
          name: x['name_th'],
        ),
      );
    }
    return provinceList;
  }

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
    final GraphQLClient client = GraphQLClient(
        link: HttpLink('https://better-prong-railway.glitch.me/district'),
        cache: GraphQLCache());
    const String query = """
        query (\$provinceId: String) {
          district (province_id: \$provinceId) {
            id
            name_th
          }
        }
      """;
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
        variables: {
          'provinceId': provinceId,
        },
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }
    final data = result.data!['district'] as List;
    final List<Amphure> amphureList = [];

    for (var x in data) {
      amphureList.add(
        Amphure(
          id: x['id'].toString(),
          name: x['name_th'],
          provinceId: x['province_id'].toString(),
        ),
      );
    }
    return amphureList;

    // try {
    //   final res = await http.get(Uri.parse(amphureEndpoint));
    //   final resList = List.from(jsonDecode(res.body) as List);
    //   final List<Amphure> amphureList = [];
    //   for (var x in resList) {
    //     amphureList.add(
    //       Amphure(
    //         id: x['id'].toString(),
    //         name: x['name_th'],
    //         provinceId: x['province_id'].toString(),
    //       ),
    //     );
    //   }
    //   return amphureList
    //       .where((element) => element.provinceId == provinceId)
    //       .toList();
    // } catch (e) {
    //   print(e);
    //   throw e;
    // }
  }

  Future<List<Tambon>> getTambonByAmphureId(String amphureId) async {
    final GraphQLClient client = GraphQLClient(
        link: HttpLink('https://better-prong-railway.glitch.me/subdistrict'),
        cache: GraphQLCache());
    const String query = """
        query(\$amphureId: String) {
          subdistrict(amphure_id: \$amphureId) {
            id
            name_th
          }
        }
      """;
    final QueryResult result = await client.query(QueryOptions(
      document: gql(query),
      variables: {
        'amphureId': amphureId,
      },
    ));

    if (result.hasException) {
      throw result.exception!;
    }
    final data = result.data!['subdistrict'] as List;
    final List<Tambon> tambonList = [];

    for (var x in data) {
      tambonList.add(
        Tambon(
          id: x['id'].toString(),
          name: x['name_th'],
          amphureId: x['amphure_id'].toString(),
          code: x['zip_code'].toString(),
        ),
      );
    }
    return tambonList;

    // try {
    //   final res = await http.get(Uri.parse(tambonEndpoint));
    //   final resList = List.from(jsonDecode(res.body) as List);
    //   final List<Tambon> tambonList = [];

    //   for (var x in resList) {
    //     tambonList.add(
    //       Tambon(
    //         id: x['id'].toString(),
    //         name: x['name_th'],
    //         amphureId: x['amphure_id'].toString(),
    //         code: x['zip_code'].toString(),
    //       ),
    //     );
    //   }
    //   return tambonList
    //       .where((element) => element.amphureId == amphureId)
    //       .toList();
    // } catch (e) {
    //   print(e);
    //   throw e;
    // }
  }
}
