import 'package:contact_app/screen/home/controller/home_controller.dart';
import 'package:contact_app/screen/home/model/firebase_model.dart';
import 'package:contact_app/utils/helper/firebasedb_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/helper/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text("Contact App"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/backup");
            },
            icon: Icon(Icons.backup),
          )
        ],
      ),
      body: Obx(
        () => controller.dbList.isNotEmpty ?ListView.builder(
          itemCount: controller.dbList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  onLongPress: () async {
                    DatabaseHelper.helper.deleteDb(controller.dbList[index].cid!);
                    controller.readData();
                  },
                  title: Row(
                    children: [
                      Text("${controller.dbList[index].name}"),
                      IconButton(
                        onPressed: () async {
                          FireDbModel model = FireDbModel(
                              name: controller.dbList[index].name,
                              mobile: controller.dbList[index].mobile);
                         await FirebasedbHelper.helper.setData(model);
                         await controller.fireDbData();
                        },
                        icon: Icon(Icons.backup),
                      )
                    ],
                  ),
                  subtitle: Text("${controller.dbList[index].mobile}"),
                  trailing: IconButton(
                    onPressed: () async {
                      Uri call = Uri(
                          scheme: 'tel',
                          path: "${controller.dbList[index].mobile}");
                      await launchUrl(call);
                    },
                    icon: Icon(Icons.call),
                  ),
                  leading: IconButton(onPressed: () {

                  }, icon: Icon(Icons.person)),
                ),
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.9,child: Divider()),
              ],
            );
          },
        ) :Center(child: Text("No Contact")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        onPressed: () {
          Get.toNamed("/contact");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
