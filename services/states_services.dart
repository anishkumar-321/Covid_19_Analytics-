import 'dart:convert';

import 'package:covid19_tracker/model/worldstates_model.dart';
import 'package:covid19_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception('Error');
    }
  }
}
