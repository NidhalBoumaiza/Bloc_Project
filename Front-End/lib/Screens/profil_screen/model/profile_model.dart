import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Profile {
  String? username;
  String? firstName;
  String? lastName;
  RxList<String>? categories;
  RxInt? distance;

  Profile({
    this.username,
    this.firstName,
    this.lastName,
    this.categories,
    this.distance,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    categories = RxList(json['categories'].cast<String>());
    distance = RxInt(json['distance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['categories'] = this.categories;
    data['distance'] = this.distance;
    return data;
  }
}
