import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../user_model.dart';



class UserController extends GetxController {
  var isLoading = true.obs;
  var userList = <User>[].obs;
  var userDetails = Rxn<UserDetails>();

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('http://143.198.61.94:8000/api/customers/'));
      if (response.statusCode == 200) {
        //print('Response body: ${response.body}');
        var jsonResponse = json.decode(response.body);
        // if (jsonResponse is List) {
        //   userList.value = jsonResponse.map((user) => User.fromJson(user)).toList();
        // }
         if (jsonResponse is Map) {
          var dataList = jsonResponse['data'] as List;
          userList.value = dataList.map((user) => User.fromJson(user)).toList();
        } else {
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      //print(e);
    } finally {
      isLoading(false);
    }
  }


  Future<void> fetchUserById(int userId) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://143.198.61.94:8000/api/customers/?id=$userId'));
      print('API Response Status Code: ${response.statusCode}');
      print('API Response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['error_code'] == 0) {
       //userDetails.value = UserDetails.fromJson(json.decode(response.body));
          userDetails.value = UserDetails.fromJson(responseData['data']);
          print('UserDetails: ${userDetails.value}');
      } else {
          print('Error in API response: ${responseData['message']}');
          userDetails.value = null;

        }
        userDetails.value = null;
        print('Failed to load user details with status: ${response.statusCode}'); // Debug statement
      }
    } catch (e) {
      print('Error fetching user details: $e');
      userDetails.value = null;
    } finally {
      isLoading(false);
    }
  }
}







