// import 'dart:typed_data';

// /// Contact entity class representing a device contact
// /// 
// /// This entity defines the structure for device contacts that are also
// /// users of the WhatsApp Clone application.
// class ContactEntity {
//   /// Display name or label of the contact
//   final String? label;
  
//   /// Unique identifier (UID) of the contact from Firebase
//   final String? uid;
  
//   /// Status message of the contact
//   final String? status;
  
//   /// Phone number of the contact
//   final String? phoneNumber;
  
//   /// Profile picture of the contact as binary data
//   final Uint8List? userProfile;
//   // final String? ;

//   ContactEntity({
//      this.label,
//      this.uid,
//      this.status,
//      this.userProfile,
//      this.phoneNumber,
//   });
// }
import 'dart:typed_data';

import 'package:flutter_contacts/flutter_contacts.dart';

class ContactEntity {
  final String? id;
  final String? displayName;
  final Uint8List? photo;
  final Uint8List? thumbnail;
  final Name? name;
  final List<Phone>? phones;
  final List<Email>? emails;
  final List<Address>? addresses;
  final List<Organization>? organizations;
  final List<Website>? websites;
  final List<SocialMedia>? socialMedias;
  final List<Event>? events;
  final List<Note>? notes;
  final List<Group>? groups;

  ContactEntity(
      {this.id,
        this.displayName,
        this.photo,
        this.thumbnail,
        this.name,
        this.phones,
        this.emails,
        this.addresses,
        this.organizations,
        this.websites,
        this.socialMedias,
        this.events,
        this.notes,
        this.groups});
}