import 'package:responsi/Network/BaseNetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> getCategory() {
    return BaseNetwork.get('categories.php');
  }

  Future<Map<String, dynamic>> getMeals(String category) {
    return BaseNetwork.get('filter.php?c=${category}');
  }

  Future<Map<String, dynamic>> getDetail(String id) {
    return BaseNetwork.get('lookup.php?i=${id}');
  }
}
