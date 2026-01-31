import 'dart:typed_data';

/// Contact entity class representing a device contact
/// 
/// This entity defines the structure for device contacts that are also
/// users of the WhatsApp Clone application.
class ContactEntity {
  /// Display name or label of the contact
  final String? label;
  
  /// Unique identifier (UID) of the contact from Firebase
  final String? uid;
  
  /// Status message of the contact
  final String? status;
  
  /// Phone number of the contact
  final String? phoneNumber;
  
  /// Profile picture of the contact as binary data
  final Uint8List? userProfile;

  ContactEntity({
     this.label,
     this.uid,
     this.status,
     this.userProfile,
     this.phoneNumber,
  });
}