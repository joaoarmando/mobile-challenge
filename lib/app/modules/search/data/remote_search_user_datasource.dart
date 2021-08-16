import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mobile_challenge/app/shared/utils/endpoints.dart';

import '../infra/datasources/search_user_datasource.dart';
import '../infra/models/searched_user_model.dart';

class RemoteSearchUserDataSource implements SearchUserDataSource {
  final Client http;

  RemoteSearchUserDataSource(this.http);
  @override
  Future<List<SearchedUserModel>> search(String searchText) async {
    final endpoint = Endpoints.searchUser + searchText;

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final items = body["items"] as List;

        final users = items.map((item) => SearchedUserModel.fromMap(item)).toList();

        return users;
    } else {
      throw Exception();
    }
  }
}