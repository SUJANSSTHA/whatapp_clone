// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:whatapp_clone/features/app/const/app_const.dart';
import 'package:whatapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatapp_clone/features/app/home/home_page.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';

/// [InitalProfileSubmitPage] is a stateful widget that allows users to set up
/// their initial profile with a username and optional profile photo.
/// This page is typically shown on the first app launch or during user onboarding.
class InitalProfileSubmitPage extends StatefulWidget {
  final String phoneNumber;
  const InitalProfileSubmitPage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<InitalProfileSubmitPage> createState() =>
      _InitalProfileSubmitPageState();
}

/// State class for [InitalProfileSubmitPage]
/// Manages the profile setup form with username input and image selection
class _InitalProfileSubmitPageState extends State<InitalProfileSubmitPage> {
  /// Controller for managing the username input field
  final TextEditingController _usernameController = TextEditingController();

  /// Stores the selected profile image file
  /// Null if no image has been selected yet
  File? _image;

  /// Opens the device's image gallery and allows the user to select a profile photo
  /// Updates [_image] with the selected file path
  /// Shows error toast if image selection fails
  Future selectImage() async {
    try {
      // Request access to device gallery and get the selected image
      final pickedImage = await ImagePicker.platform.getImageFromSource(
        source: ImageSource.gallery,
      );

      // Update the UI with the selected image
      setState(() {
        if (pickedImage != null) {
          // Convert the picked image path to a File object
          _image = File(pickedImage.path);
        } else {
          // User canceled the image picker without selecting an image
          print("No image selected");
        }
      });
    } catch (e) {
      // Display error message if image picking fails (e.g., permission denied)
      toast("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            // Top spacing
            SizedBox(height: 40),

            // Page title - "Profile Info"
            Center(
              child: Text(
                "Profile Info",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: tabColor,
                ),
              ),
            ),

            // Subtitle describing what the user needs to do
            SizedBox(height: 10),
            Text(
              "Please provide your name and an optional profile photo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: textColor),
            ),

            // Spacing before profile photo selector
            SizedBox(height: 30),

            // Profile photo selector - tapping opens image picker
            GestureDetector(
              onTap: selectImage,
              child: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  // Circular profile image
                  borderRadius: BorderRadius.circular(25),
                  // Displays the selected profile image or default placeholder
                  child: profileWidget(image: _image),
                ),
              ),
            ),

            // Spacing after profile photo
            SizedBox(height: 10),

            // Username input field with custom border styling
            Container(
              height: 40,
              margin: const EdgeInsets.only(top: 1.5),
              decoration: BoxDecoration(
                // Green border to match the app theme
                border: Border.all(color: tabColor, width: 1.5),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  // No default border - using container border instead
                  border: InputBorder.none,
                ),
                // Text color for visibility on dark background
                style: TextStyle(color: textColor),
              ),
            ),

            // Spacing before action button
            SizedBox(height: 30),

            // Submit button - navigates to HomePage after profile setup
            GestureDetector(
              onTap: () {
                // TODO: Add profile validation and save username + image before navigation
                // Currently navigates to HomePage without submitting profile data
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomePage()
                //   ),(route) => false,
                // );
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  // Green button matching app theme
                  color: tabColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
