import 'package:flutter/material.dart';

class PickupInfoModel extends ChangeNotifier {
  DateTime _deliveryDateTime = DateTime.now();
  String _address;

  DateTime get deliveryDateTime => _deliveryDateTime;
  set deliveryDateTime(DateTime value) {
    _deliveryDateTime = value;
    notifyListeners();
  }
  String get address => _address;
  set address(String value){
    _address = value;
    notifyListeners();
  }

  void setTommorowDeliveryDateTime(){
    _deliveryDateTime = DateTime.now().add(Duration(days: 1));
    notifyListeners();
  }

  Iterable<String> getPickupAdresses() sync* {
    for (var i = 0; i < 3; i++) {
      yield 'Address$i';
    }
  }
}