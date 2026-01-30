import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:whatapp_clone/features/user/presentation/pages/inital_profile_submit_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Verify your OTP",
                      style: TextStyle(
                        fontSize: 20,
                        color: tabColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Enter your OTP for the WhatsApp Clone Verification.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15,color: textColor),
                  ),
                  SizedBox(height: 20),
                  //* Add OTP input fields and verification button here
                  _pinCodeWidget(),
                  SizedBox(height: 30),
                ],
              ),
            ),

             GestureDetector(
                    onTap: (){
                      // Handle next button tap
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const InitalProfileSubmitPage()));
                    },
                    
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: tabColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
              
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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

  Widget _pinCodeWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          PinCodeFields(
            controller: _otpController,
            length: 6,
            activeBorderColor: tabColor,

            onComplete: (String pinCode) {},
          ),
          const Text("Enter your 6 digit code", style: TextStyle(fontSize: 12, color: whiteColor)),
        ],
      ),
    );
  }
}