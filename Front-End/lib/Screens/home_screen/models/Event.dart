import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Events {
  List<Event>? ListEvent;

  Events({this.ListEvent});

  Events.fromJson(Map<String, dynamic> json) {
    if (json['nearby_pref_cat_events'] != null) {
      ListEvent = <Event>[];
      json['nearby_pref_cat_events'].forEach((v) {
        ListEvent!.add(Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ListEvent != null) {
      data['nearby_pref_cat_events'] =
          ListEvent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Event {
  int? id;
  RxString? name;
  RxString? locationName;
  RxString? eventCategory;
  RxString? picture;
  RxString? startDate;
  RxString? endDate;
  RxString? creator;
  RxString? link;
  RxInt? score;
  RxInt? like;

  Event(
      {this.id,
      this.name,
      this.locationName,
      this.eventCategory,
      this.picture,
      this.startDate,
      this.endDate,
      this.creator,
      this.link,
      this.score,
      this.like});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = RxString(json['name']);
    locationName = RxString(json['location_name']);
    eventCategory = RxString(json['event_category']);
    picture = RxString(json['picture']);
    startDate = RxString(json['start_date']);
    endDate = RxString(json['end_date']);
    creator = RxString(json['creator']);
    link = RxString(json['link']);
    score = RxInt(json['score']);
    like = RxInt(json['like']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location_name'] = locationName;
    data['event_category'] = eventCategory;
    data['picture'] = picture;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['creator'] = creator;
    data['link'] = link;
    return data;
  }
}
