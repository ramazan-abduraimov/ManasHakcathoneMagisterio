import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class ForumSentCheck extends StatefulWidget {
  const ForumSentCheck({Key? key}) : super(key: key);

  @override
  State<ForumSentCheck> createState() => _ForumSentCheckState();
}

class _ForumSentCheckState extends State<ForumSentCheck> {
  String _selectedLanguage = 'English';

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    print('Language changed to: $language');
  }

  double sizeLogo = 45;

  final _formKey = GlobalKey<_UserDataFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          title: Row(
            children: [
              Image.asset(
                "assets/image/Logo.png",
                width: sizeLogo,
                height: sizeLogo,
              ),
              SizedBox(width: 10),
              Text(
                'Выбери язык: $_selectedLanguage',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                _showLanguageSelectionDialog(context);
              },
            ),
            GestureDetector(
              child: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(
                  'assets/image/avatarka.png',
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _UserDataForm(key: _formKey),
              SizedBox(height: 15,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(184, 9, 36, 1.0),
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all(Size(350, 50)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                onPressed: () {
                  _formKey.currentState?.sendDataToAPI();
                },
                child: Text(
                  "Apply Now ",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('English'),
              _buildLanguageOption('Russian'),
              _buildLanguageOption('Turkish'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(language),
      onTap: () {
        _changeLanguage(language);
        Navigator.pop(context);
      },
    );
  }
}

class _UserDataForm extends StatefulWidget {
  const _UserDataForm({Key? key}) : super(key: key);

  @override
  _UserDataFormState createState() => _UserDataFormState();
}

class _UserDataFormState extends State<_UserDataForm> {
  String name = '';
  String surname = '';
  String date = '';
  String gender = '';
  String address = '';
  String country = '';
  String region = '';
  String street = '';
  String postalCode = '';

  List<File> diplomaFiles = [];
  List<File> transcriptFiles = [];
  List<File> militaryIdFiles = [];
  List<File> otherDocumentFiles = [];

  void selectFile(BuildContext context, List<File> fileList) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      setState(() {
        List<File> selectedFiles = result.paths.map((path) => File(path!)).toList();
        fileList.addAll(selectedFiles);
      });
    } else {
      // User canceled the picker
    }
  }

  void sendDataToAPI() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.95.79:8080/api/data13'),
      );

      request.fields['name'] = name;
      request.fields['surname'] = surname;
      request.fields['date'] = date;
      request.fields['gender'] = gender;
      request.fields['address'] = address;
      request.fields['country'] = country;
      request.fields['region'] = region;
      request.fields['street'] = street;
      request.fields['postalCode'] = postalCode;

      for (var file in diplomaFiles) {
        request.files.add(await http.MultipartFile.fromPath(
          'diplomaFiles',
          file.path,
        ));
      }
      for (var file in transcriptFiles) {
        request.files.add(await http.MultipartFile.fromPath(
          'transcriptFiles',
          file.path,
        ));
      }
      for (var file in militaryIdFiles) {
        request.files.add(await http.MultipartFile.fromPath(
          'militaryIdFiles',
          file.path,
        ));
      }
      for (var file in otherDocumentFiles) {
        request.files.add(await http.MultipartFile.fromPath(
          'otherDocumentFiles',
          file.path,
        ));
      }

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Data sent successfully! ${response.body}');
      } else {
        print('Failed to send data. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        _buildTextField("Name", name),
        _buildTextField("Surname", surname),
        _buildDateTextField("Date", date),
        _buildTextField("Gender", gender),
        _buildTextField("Address", address),
        _buildTextField("Country", country),
        _buildTextField("Region", region),
        _buildTextField("Street", street),
        _buildTextField("Postal Code", postalCode),
        SizedBox(height: 20),
        _buildFileSelectionButton("Диплом из нескольких частей файла,", diplomaFiles),
        _buildFileSelectionButton("Расшифровка из нескольких частей файла,", transcriptFiles),
        _buildFileSelectionButton("Военный билет из нескольких частей файла,", militaryIdFiles),
        _buildFileSelectionButton("Другой документ из нескольких частей файла", otherDocumentFiles),
      ],
    );
  }

  Widget _buildTextField(String label, String value) {
    if (label == "Gender") {
      return _buildGenderDropdown(label, value);
    } else {
      return TextField(
        decoration: InputDecoration(labelText: label),
        onChanged: (newValue) {
          setState(() {
            switch (label) {
              case 'Name':
                name = newValue;
                break;
              case 'Surname':
                surname = newValue;
                break;
              case 'Address':
                address = newValue;
                break;
              case 'Country':
                country = newValue;
                break;
              case 'Region':
                region = newValue;
                break;
              case 'Street':
                street = newValue;
                break;
              case 'Postal Code':
                postalCode = newValue;
                break;
            }
          });
        },
      );
    }
  }

  Widget _buildDateTextField(String label, String value) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: TextEditingController(text: value),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        date = pickedDate.toString(); // Update the date variable
      });
    }
  }

  Widget _buildGenderDropdown(String label, String value) {
    if (value != "Male" && value != "Female") {
      value = "Male";
    }

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: value,
      onChanged: (newValue) {
        setState(() {
          gender = newValue!;
        });
      },
      items: <String>['Male', 'Female'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildFileSelectionButton(String label, List<File> fileList) {
    bool hasFiles = fileList.isNotEmpty;
    String buttonText = hasFiles ? 'File Selected' : label;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350.0, 50.0),
              ),
              onPressed: () => selectFile(context, fileList),
              child: Text(buttonText),
            ),
          ),
        ),
        if (hasFiles)
          Icon(Icons.check, color: Colors.green),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ForumSentCheck(),
  ));
}
