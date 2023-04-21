import 'package:equatable/equatable.dart';

class DeviceModel extends Equatable {
  final String id;
  final String name;
  final String registrationID;
  final String deviceID;
  final bool active;
  final String dateCreated;
  final String type;
  final String location;
  final List<Activity>? activities;

  const DeviceModel({
    required this.id,
    required this.name,
    required this.registrationID,
    required this.deviceID,
    required this.active,
    required this.dateCreated,
    required this.type,
    required this.location,
    required this.activities,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        id: json['id'],
        name: json['name'],
        registrationID: json['registration_id'],
        deviceID: json['device_id'],
        active: json['active'],
        dateCreated: json['date_created'],
        type: json['type'],
        location:
            json['location'] ?? 'Poznan, Poland',
        activities: json['activities'] != null
            ? json['activities'].map((e) => Activity.fromJson(e)).toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'registration_id': registrationID,
        'device_id': deviceID,
        'active': active,
        'date_created': dateCreated,
        'type': type,
        'location': location,
        'activities': activities!.map((e) => e.toJson()),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      registrationID,
      deviceID,
      active,
      dateCreated,
      type,
      activities!.map((e) => e.toJson()),
    ];
  }
}

class Activity {
  final String activity;
  final String location;
  final String ipAddress;
  final String timeAgo;
  final String status;

  const Activity({
    required this.activity,
    required this.location,
    required this.ipAddress,
    required this.timeAgo,
    required this.status,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        activity: json['activity'],
        location: json['location'],
        ipAddress: json['ipAddress'],
        timeAgo: json['timeAgo'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'activity': activity,
        'location': location,
        'ipAddress': ipAddress,
        'timeAgo': timeAgo,
        'status': status,
      };
}

class DeviceModelList {
  DeviceModelList({required this.list});

  factory DeviceModelList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return DeviceModel.fromJson(value as Map<String, dynamic>);
    }).toList();
    return DeviceModelList(list: list);
  }

  final List<DeviceModel> list;
}
