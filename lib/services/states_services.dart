import 'dart:convert';

import 'package:covid_19_tracker/model/world_state_model.dart';
import 'package:covid_19_tracker/services/utlities/app_url.dart';
import 'package:covid_19_tracker/view/countries_list.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateModel> fecthWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return new WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> CountriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
