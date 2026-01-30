import 'package:equatable/equatable.dart';

/// User entity class representing a user in the application
/// 
/// This entity defines the core user model with all necessary properties
/// for user representation throughout the application.
/// It extends [Equatable] for easy comparison and value-based equality.
class UserEntity extends Equatable {
  /// Username of the user
  final String? username;
  
  /// Email address of the user
  final String? email;
  
  /// Phone number of the user with country code
  final String? phoneNumber;
  
  /// Online status of the user
  final bool? isOnline;
  
  /// Unique identifier (UID) from Firebase Authentication
  final String? uid;
  
  /// User's status message or bio
  final String? status;
  
  /// URL to user's profile picture
  final String? profileUrl;

  const UserEntity({
    this.username,
    this.email,
    this.phoneNumber,
    this.isOnline,
    this.uid,
    this.status,
    this.profileUrl,
  });

  @override
  List<Object?> get props => [
    username,
    email,
    phoneNumber,
    isOnline,
    uid,
    status,
    profileUrl,
  ];
}
