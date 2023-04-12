import 'dart:convert';

import 'package:covid_19_tracker/model/world_state_model.dart';
import 'package:covid_19_tracker/services/utlities/app_url.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateModel> fecthWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return new WorldStateModel.fromJson(data);
    } else {
      throw new Exception('Error');
    }
  }
}
