import 'package:myapp/repository/database.dart';

class AddressInfo {
  int id;
  String address;
  String name;
  String phone;
  String comment;

  AddressInfo({this.id, this.address, this.name, this.phone, this.comment});

  factory AddressInfo.fromMap(Map<String, dynamic> json) => new AddressInfo(
        id: json["id"],
        address: json["address"],
        name: json["name"],
        phone: json["phone"],
        comment: json["comment"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "address": address,
        "name": name,
        "phone": phone,
        "comment": comment
      };
}

class AddressInfoModel {
  Future<List<AddressInfo>> get addresses =>
      DataRepository().getAddresses();

  Future<AddressInfo> getAddressById(int id) => DataRepository().getAdressesById(id);
}
