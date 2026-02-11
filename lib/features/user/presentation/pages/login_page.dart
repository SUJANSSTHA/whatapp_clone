import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatapp_clone/features/app/const/app_const.dart';
import 'package:whatapp_clone/features/app/home/home_page.dart';

import 'package:whatapp_clone/features/app/theme/style.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/pages/inital_profile_submit_page.dart';
import 'package:whatapp_clone/features/user/presentation/pages/otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  // late Country _selectedFilteredDialogCountry;
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("977");
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber = "";
  // late String _countryCode;

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode(
  //     "977",
  //   );
  //   _countryCode = _selectedFilteredDialogCountry.phoneCode;
  // }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
  listener:(context, credentialListenerState) {
        if(credentialListenerState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if(credentialListenerState is CredentialFailure) {
          toast("Something went wrong");
        }
      },
  builder: (context, credentialBuilderState) {
        if(credentialBuilderState is CredentialLoading) {
          return const Center(child: CircularProgressIndicator(color: tabColor,),);
        }
        if(credentialBuilderState is CredentialPhoneAuthSmsCodeReceived) {
          return const OtpPage();
        }
        if(credentialBuilderState is CredentialPhoneAuthProfileInfo) {
          return InitalProfileSubmitPage(phoneNumber: _phoneNumber);
        }
        if(credentialBuilderState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState){
              if(authState is Authenticated) {
                return HomePage(uid: authState.uid,);
              }
              return _bodyWidget();
            },
          );
        }
        return _bodyWidget();
      },
 
);
  }

 _bodyWidget(){
  return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Verify your phone number",
                      style: TextStyle(
                        fontSize: 20,
                        color: tabColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "WhatsApp Clone will send an SMS message (carrier changes may apply) to verify your phone number. Enter your country code and phone number.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: whiteColor),
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                    onTap: _openFilterdCountryPickerDialog,
                    title: _buildDialogItem(_selectedFilteredDialogCountry),
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         border: Border(
                  //           bottom: BorderSide(color: tabColor, width: 1.5),
                  //         ),
                  //       ),
                  //       width: 80,
                  //       height: 40  ,
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         _selectedFilteredDialogCountry.phoneCode
                  //       ),
                  //     ),
                  //     SizedBox(width: 10),
                  //     Expanded(
                  //       child: TextField(
                  //         controller: _phoneController,
                  //         keyboardType: TextInputType.phone,
                  //         style: TextStyle(color: whiteColor),
                  //         decoration: InputDecoration(
              
                  //           hintText: "Phone Number",
                  //           border: InputBorder.none,
                  //           hintStyle: TextStyle(
              
                  //             color: Colors.white54),
                  //           enabledBorder: UnderlineInputBorder(
                  //             borderSide: BorderSide(color: tabColor),
                  //           ),
                  //           focusedBorder: UnderlineInputBorder(
                  //             borderSide: BorderSide(color: tabColor),
                  //           ),
                  //         ),
                  //         onChanged: (value) {
                  //           setState(() {
                  //             _phoneNumber = value;
                  //           });
                  //         },
                  //       ),
                  //     )
                  //   ],
                  // )
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextField(
                          // _selectedFilteredDialogCountry.phoneCode
                          controller: TextEditingController(text: _countryCode),
                          enabled: false,
                          style: TextStyle(color: whiteColor),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: tabColor),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: tabColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: whiteColor),
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Colors.white54),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: tabColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: tabColor),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _phoneNumber = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: (){
                  //     // Handle next button tap
              
                  //   },
                    
                  //   child: Container(
                  //     margin: const EdgeInsets.only(bottom: 20),
                  //     width: 120,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       color: tabColor,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
              
                  //       child: Text(
                  //         "Next",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
             GestureDetector(
              //       onTap: (){
              //         // Handle next button tap
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const OtpPage()));
              //       },
              onTap: _submitVerifyPhoneNumber,
                    
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
  // * deepseaked change here
  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: tabColor, width: 1.5)),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Use network image for flag
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.network(
              "https://flagcdn.com/w40/${country.isoCode.toLowerCase()}.png",
              width: 25,
              height: 35,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40,
                  height: 26,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Text(
                    country.isoCode.toUpperCase(),
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            "+${country.phoneCode}",
            style: TextStyle(
              color: whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              country.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: whiteColor),
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_drop_down, color: tabColor),
        ],
      ),
    );
  }
  // * deepseaked change here

  // Widget _buildDialogItem(Country country) {
  //   return Container(
  //     height: 40,
  //     decoration: BoxDecoration(
  //       border: Border(bottom: BorderSide(color: tabColor, width: 1.5)),
  //     ),
  //     alignment: Alignment.center,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         CountryPickerUtils.getDefaultFlagImage(country),
  //         const SizedBox(width: 8.0),
  //         Text(
  //           "+${country.phoneCode}",
  //           style: TextStyle(
  //             color: whiteColor,
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         const SizedBox(width: 8.0),
  //         // Flexible(child: Text(country.name, overflow: TextOverflow.ellipsis,style: TextStyle(color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500,)),),
  //         Expanded(child: Text(country.name, overflow: TextOverflow.ellipsis)),
  //         const Spacer(),
  //         const Icon(Icons.arrow_drop_down, color: tabColor),
  //         // const Icon(Icons.arrow_drop_down),
  //       ],
  //     ),
  //   );
  // }

  void _openFilterdCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: tabColor),
        child: CountryPickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          searchCursorColor: tabColor,
          searchInputDecoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
          isSearchable: true,
          title: const Text(
            'Select your phone code',
            style: TextStyle(color: Colors.white),
          ),
          onValuePicked: (Country country) {
            setState(() {
              _selectedFilteredDialogCountry = country;
              _countryCode = country.phoneCode;
            });
          },
          itemBuilder: _buildDialogItem,
        ),
      ),
    );
  }

  void _submitVerifyPhoneNumber(){
    if(_phoneController.text.isNotEmpty){
      _phoneNumber="+$_countryCode${_phoneController.text}";
      print("phoneNumber $_phoneNumber");
      BlocProvider.of<CredentialCubit>(context).submitVerifyPhoneNumber(phoneNumber: _phoneNumber,);

    }else{
      toast("Enter your phone number");
    }
  }
}
