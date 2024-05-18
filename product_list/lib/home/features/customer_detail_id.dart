import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_list/customer/controller/user_controller.dart';

import '../../customer/user_model.dart';

class CustomerDetailIdScreen extends StatefulWidget {
  @override
  _CustomerDetailIdScreenState createState() => _CustomerDetailIdScreenState();
}

class _CustomerDetailIdScreenState extends State<CustomerDetailIdScreen> {
  final UserController userController = Get.find<UserController>();
  int? userId;

  // final int userId = Get.arguments;

  // CustomerDetailIdScreen({required this.userId});
  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to ensure fetchUserById is called after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userId = Get.arguments as int?;
        print('userId retrieved in initState: $userId');
        if (userId != null) {
          print(userId);
          userController.fetchUserById(userId!);
        } else {
          print('No user ID provided');
        }

        print(userId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (userId == null) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text('Customer Detail'),
    //     ),
    //     body: Center(
    //       child: Text('No customer ID provided.'),
    //     ),
    //   );
    // }

    // userController.fetchUserById(userId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: userId == null
          ? Center(
        child: Text('No customer ID provided.'),
      )
          :Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          UserDetails? userDetails = userController.userDetails.value;
          print('UserDetails in UI: $userDetails');
          //print('Displaying user=======: $userDetails');
          //
          // print('Displaying userid=======: $useridd');
          if (userDetails == null) {
            // && user.name == null && user.email == null && user.mobileNumber == null && user.city == null
            return const Center(child: Text('No details available'));
          } else {
            //UserDetails userDetails = userController.userDetails.value;
            print('Displaying user=======: $userDetails');
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${userDetails.name ?? 'No Name'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: ${userDetails.email ?? 'No Email'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mobile Number: ${userDetails.mobileNumber ?? 'No Mobile Number'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'City: ${userDetails.city ?? 'No City'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      }),
    );
  }
}
