// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Appointments {
  String name;
  String id;
  String service;
  String status;
  DateTime time;
  Appointments({
    required this.name,
    required this.id,
    required this.service,
    required this.status,
    required this.time,
  });

  Appointments copyWith({
    String? name,
    String? id,
    String? service,
    String? status,
    DateTime? time,
  }) {
    return Appointments(
      name: name ?? this.name,
      id: id ?? this.id,
      service: service ?? this.service,
      status: status ?? this.status,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'service': service,
      'status': status,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Appointments.fromMap(Map<String, dynamic> map) {
    return Appointments(
      name: map['name'] as String,
      id: map['id'] as String,
      service: map['service'] as String,
      status: map['status'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointments.fromJson(String source) =>
      Appointments.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Appointments(name: $name, id: $id, service: $service, status: $status, time: $time)';
  }

  @override
  bool operator ==(covariant Appointments other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.service == service &&
        other.status == status &&
        other.time == time;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        service.hashCode ^
        status.hashCode ^
        time.hashCode;
  }
}
