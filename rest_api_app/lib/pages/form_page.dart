import 'package:flutter/material.dart';
import 'package:rest_api_app/api_service.dart';
import 'package:rest_api_app/model/user.dart';
import 'package:rest_api_app/pages/user_data_view_page.dart';
import 'package:rest_api_app/widgets/custom_button.dart';
import 'package:rest_api_app/widgets/input_field.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({
    super.key,
    this.userModel,
  });

  final User? userModel;

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _surNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _regionController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _profController = TextEditingController();
  String? gender;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _surNameController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _phoneNoController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _regionController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    _profController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final userModel = User(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        surName: _surNameController.text,
        gender: gender!,
        dateOfBirth: _dateOfBirthController.text,
        email: _emailController.text,
        phoneNo: _phoneNoController.text,
        streetAddress: _streetAddressController.text,
        profession: _profController.text,
        city: _cityController.text,
        zipCode: _zipCodeController.text,
        country: _countryController.text,
        region: _regionController.text,
      );

      final res = widget.userModel == null
          ? await apiService.addUser(
              userModel.toJson(),
            )
          : await apiService.updateUser(
              userModel.toJson(),
            );

      debugPrint(
          "User Name: ${userModel.firstName} ${userModel.lastName} \nResponse: ${res.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Form Submitted successfully!",
          ),
        ),
      );
      _clearForm();
    }
  }

  void _clearForm() {
    setState(() {
      _firstNameController.clear();
      _lastNameController.clear();
      _surNameController.clear();
      _dateOfBirthController.clear();
      _emailController.clear();
      _phoneNoController.clear();
      _streetAddressController.clear();
      _cityController.clear();
      _regionController.clear();
      _zipCodeController.clear();
      _countryController.clear();
      _profController.clear();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfBirthController.text =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  void initState() {
    if (widget.userModel != null) {
      _firstNameController.text = widget.userModel!.firstName;
      _lastNameController.text = widget.userModel!.lastName;
      _surNameController.text = widget.userModel!.surName!;
      _dateOfBirthController.text = widget.userModel!.dateOfBirth;
      _emailController.text = widget.userModel!.email;
      _phoneNoController.text = widget.userModel!.phoneNo;
      _streetAddressController.text = widget.userModel!.streetAddress!;
      _cityController.text = widget.userModel!.city!;
      _regionController.text = widget.userModel!.region!;
      _zipCodeController.text = widget.userModel!.zipCode!;
      _countryController.text = widget.userModel!.country!;
      _profController.text = widget.userModel!.profession!;
      gender = widget.userModel!.gender;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.push(context, UserDataViewPage.route()),
              icon: Icon(
                Icons.ballot_rounded,
                color: Colors.black54,
              ),
            ),
          ],
          title: Text("Personal Information Form"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: _firstNameController,
                        labelText: 'First Name',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter first name'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputField(
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter last name'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                InputField(
                  controller: _surNameController,
                  labelText: 'Surname',
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                InputField(
                  controller: _dateOfBirthController,
                  readOnly: true,
                  labelText: 'YYYY-MM-DD',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Select date of birth'
                      : null,
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                InputField(
                  controller: _streetAddressController,
                  labelText: 'Street Address',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter street address'
                      : null,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: _cityController,
                        labelText: 'City',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter city'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputField(
                        controller: _regionController,
                        labelText: 'Region',
                        validator: (value) => null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: _zipCodeController,
                        labelText: 'Postal / Zip Code',
                        validator: (value) => null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputField(
                        controller: _countryController,
                        labelText: 'Country',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter country'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: gender,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: gender,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (gender == null)
                  const Text(
                    "Select gender",
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                InputField(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                InputField(
                  controller: _phoneNoController,
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter phone number'
                      : null,
                ),
                SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    'Profession',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                InputField(
                  controller: _profController,
                  labelText: 'Profession',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter profession';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                CustomButton(
                  onTap: _submitForm,
                  text: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
