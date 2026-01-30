import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';

import 'package:whatapp_clone/features/app/theme/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  late Country _selectedFilteredDialogCountry;
  late String _countryCode;

  @override
  void initState() {
    super.initState();
    _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode(
      "977",
    );
    _countryCode = _selectedFilteredDialogCountry.phoneCode;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
          ],
        ),
      ),
    );
  }

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
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}", style: TextStyle(color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500,),),
          const SizedBox(width: 8.0),
          // Flexible(child: Text(country.name, overflow: TextOverflow.ellipsis,style: TextStyle(color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500,)),),
          Expanded(
            child: Text(country.name, overflow: TextOverflow.ellipsis,),

          ),
          const Spacer(),
          const Icon(Icons.arrow_drop_down, color: tabColor,),
          // const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  void _openFilterdCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: tabColor),
        child: CountryPickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          searchCursorColor: tabColor,
          searchInputDecoration: const InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: const Text('Select your phone code'),
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
}
