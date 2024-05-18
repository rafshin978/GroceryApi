import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:product_list/home/features/customer_details_page.dart";
import "package:product_list/home/features/add_new_customer_page.dart";
import "package:product_list/home/features/update_customer_page.dart";
import "package:product_list/utils/app_size.dart";
import "package:product_list/utils/app_text.dart";

import "../../../customer/controller/user_controller.dart";

class DrawerMenu extends StatelessWidget {

  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              AppText.drawerMenu,
              style:  TextStyle(
                color: Colors.white,
                fontSize: AppSizes.fontSizeXl,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(AppText.drawerCustomerDetails),
            onTap: () async {
              await userController.fetchUsers();

              Get.to(() => CustomerDetailsScreen());
            },
          ),
          ListTile(
            leading:const  Icon(Icons.update),
            title:const  Text(AppText.drawerUpdateCustomer),
            onTap: () {
              Get.to(() => UpdateCustomerScreen());
            },
          ),
          ListTile(
            leading:const  Icon(Icons.add),
            title: const Text(AppText.drawerAddCustomer),
            onTap: () {
              Get.to(() => AddNewCustomerScreen());
            },
          ),
        ],
      ),
    );
  }
}


