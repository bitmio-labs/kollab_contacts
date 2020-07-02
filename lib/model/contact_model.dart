import 'dart:convert';
import 'package:flutter/services.dart';

class Contacts {
  static Future<Contacts> get examples async {
    final string = await rootBundle.loadString(
        'packages/kollab_contacts/lib/model/contact_model_examples.json');
    final json = jsonDecode(string);
    return Contacts.fromJson(json);
  }

  final List<Contact> items;

  Contacts({this.items});

  factory Contacts.fromJson(List<dynamic> json) {
    return Contacts(items: List<Contact>.from(json.map((each) {
      return Contact.fromJson(each);
    })));
  }
}

class Contact {
  final String name;
  final String role;
  final String imageURL;
  final String phone;
  final String email;
  final String officeHours;

  Contact(
      {this.name,
      this.role,
      this.imageURL,
      this.phone,
      this.email,
      this.officeHours});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        name: json['name'],
        role: json['role'],
        imageURL: json['image_url'],
        phone: json['phone'],
        email: json['email'],
        officeHours: json['office_hours']);
  }
}
