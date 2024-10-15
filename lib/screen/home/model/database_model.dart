class DatabaseModel
{
  int? mobile,cid;
  String? name;

  DatabaseModel({this.name,this.mobile,this.cid});

  factory DatabaseModel.mapToModel(Map m1)
  {
    return DatabaseModel(name: m1['name'],mobile: m1['mobile'],cid: m1['cid']);
  }
}