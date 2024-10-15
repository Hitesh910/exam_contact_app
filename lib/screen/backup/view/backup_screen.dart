import 'package:contact_app/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/helper/database_helper.dart';
import '../../../utils/helper/firebasedb_helper.dart';
import '../../home/model/firebase_model.dart';
class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fireDbData();
    print("================${controller.fireDbList[0].name}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Backup Contact"),),
      body: ListView.builder(
        itemCount: controller.fireDbList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onLongPress: () async {
                  FirebasedbHelper.helper.deleteData(controller.fireDbList[index].cid!);
                  controller.readData();
                },
                title: Row(
                  children: [
                    Text("${controller.fireDbList[index].name}"),
                    // IconButton(
                    //   onPressed: () async {
                    //     FireDbModel model = FireDbModel(
                    //         name: controller.fireDbList[index].name,
                    //         mobile: controller.dbList[index].mobile);
                    //     await FirebasedbHelper.helper.setData(model);
                    //     await controller.fireDbData();
                    //   },
                    //   icon: Icon(Icons.backup),
                    // )
                  ],
                ),
                subtitle: Text("${controller.fireDbList[index].mobile}"),
                trailing: IconButton(
                  onPressed: () async {
                    Uri call = Uri(
                        scheme: 'tel',
                        path: "${controller.fireDbList[index].mobile}");
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
      ),
    );
  }
}
