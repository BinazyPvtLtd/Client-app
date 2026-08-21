import 'package:flutter/material.dart';

class SavedAddressModel {
  final String id;
  final String title;
  final String address;
  final IconData icon;

  const SavedAddressModel({
    required this.id,
    required this.title,
    required this.address,
    required this.icon,
  });

  SavedAddressModel copyWith({
    String? id,
    String? title,
    String? address,
    IconData? icon,
  }) {
    return SavedAddressModel(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      icon: icon ?? this.icon,
    );
  }
}