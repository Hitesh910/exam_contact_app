import 'package:contact_app/screen/home/model/database_model.dart';
import 'package:contact_app/screen/home/model/firebase_model.dart';
import 'package:contact_app/utils/helper/database_helper.dart';
import 'package:contact_app/utils/helper/firebasedb_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  RxnString name = RxnString();
  RxList<DatabaseModel> dbList = <DatabaseModel>[].obs;
  RxList<FireDbModel> fireDbList = <FireDbModel>[].obs;

  Future<void> readData()
  async {
    dbList.value =await DatabaseHelper.helper.getData();
  }

  Future<void> fireDbData()
  async {
    fireDbList.value = await FirebasedbHelper.helper.getData();
  }
}