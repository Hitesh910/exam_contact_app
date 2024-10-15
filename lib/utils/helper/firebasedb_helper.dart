import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/screen/home/model/firebase_model.dart';

class FirebasedbHelper
{
  static FirebasedbHelper helper = FirebasedbHelper._();
  FirebasedbHelper._();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> setData(FireDbModel model)
  async {
   await fireStore.collection("Contact").add({"name":model.name,"mobile":model.mobile});
  }

  Future<List<FireDbModel>> getData()
  async {
  QuerySnapshot snapshot =await fireStore.collection("Contact").get();
  List<QueryDocumentSnapshot<Object?>> l1 =await snapshot.docs;
  List<FireDbModel> fireDbData = l1.map((e) => FireDbModel.mapToModel(e.data() as Map,e.id),).toList();
  print("============= fire ${fireDbData.length}");
  return fireDbData;
  }

  Future<void> deleteData(String id)
  async {
   await fireStore.collection("Contact").doc(id).delete();
  }
}