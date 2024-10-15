class FireDbModel
{
  num? mobile;
  String? name,cid;

  FireDbModel({this.name,this.mobile,this.cid});

  factory FireDbModel.mapToModel(Map m1,String id)
  {print("=======================${id}");
    return FireDbModel(name: m1['name'],mobile: m1['mobile'],cid: id);
  }
}