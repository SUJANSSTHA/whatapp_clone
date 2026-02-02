import 'package:whatapp_clone/features/user/domain/entities/contact_entity.dart';
import 'package:whatapp_clone/features/user/domain/entities/user_entity.dart';

/// Abstract repository for user-related operations
/// 
/// This repository defines the contract for user authentication,
/// user data management, and contact retrieval operations.
/// Implementation should handle Firebase authentication and Firestore operations.
abstract class UserRepository {
  /// Verify phone number for authentication
  /// 
  /// Sends an OTP to the provided phone number and triggers
  /// Firebase's phone authentication flow.
  /// 
  /// Parameters:
  ///   - phoneNumber: The phone number to verify (with country code)
  Future<void> verifyPhoneNumber(String phoneNumber);

  /// Sign in user with SMS PIN code
  /// 
  /// Completes the phone authentication by verifying the SMS OTP
  /// received by the user.
  /// 
  /// Parameters:
  ///   - smsPinCode: The 6-digit OTP received via SMS
  Future<void> signInWithPhoneNumber(String smsPinCode);

  /// Check if user is currently signed in
  /// 
  /// Returns:
  ///   - true if user is authenticated, false otherwise
  Future<bool> isSignIn();

  /// Sign out the current user
  /// 
  /// Clears the user session and signs out from Firebase
  Future<void> isSignout();

  /// Get the current user's unique ID
  /// 
  /// Returns:
  ///   - The UID of the currently authenticated user
  Future<String> getCurrentUID();

  Future<void> createUser(UserEntity user);

  /// Update existing user information
  /// 
  /// Updates user profile data in Firestore
  /// 
  /// Parameters:
  ///   - user: UserEntity object with updated information
  Future<void> updateUser(UserEntity user);

  /// Get stream of all users
  /// 
  /// Returns a real-time stream of all users from Firestore
  /// Useful for displaying user lists and live updates
  /// 
  /// Returns:
  ///   - Stream of List<UserEntity> containing all users
  Stream<List<UserEntity>> getAllUsers();

  /// Get stream of a single user by UID
  /// 
  /// Returns a real-time stream of a specific user's data
  /// 
  /// Parameters:
  ///   - uid: The unique identifier of the user
  /// 
  /// Returns:
  ///   - Stream of List<UserEntity> containing the specific user
  Stream<List<UserEntity>> getSingleUser(String uid);

  /// Get contacts from device
  /// 
  /// Retrieves the device contacts and returns matching app users
  /// 
  /// Returns:
  ///   - Future<List<ContactEntity>> containing device contacts
  Future<List<ContactEntity>> getDeviceNumber();
}