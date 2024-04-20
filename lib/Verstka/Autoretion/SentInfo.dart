import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magisteria/Verstka/Autoretion/ResponsePage.dart';
import 'package:magisteria/Verstka/Autoretion/Signin.dart';

class SentInfo extends StatefulWidget {
  const SentInfo({Key? key}) : super(key: key);

  @override
  State<SentInfo> createState() => _SentInfoState();
}

class _SentInfoState extends State<SentInfo> {
  String _selectedLanguage = 'English';


  double sizeLogo = 45;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    // Implement logic to change the app's language based on the selected option
    // For demonstration purposes, we are only updating the UI
    print('Language changed to: $language');
  }

  Future<void> sendDataToAPI(BuildContext context) async {
    // Создаем тело запроса
    Map<String, String> data = {
      'name': _nameController.text,
      'surname': _surnameController.text,
      'gmail': _emailController.text,
      'password': _passwordController.text,
    };

    // Конвертируем данные в формат JSON
    String requestBody = jsonEncode(data);

    // URL API
    String apiUrl = 'http://192.168.95.79:8080/api/data12';

    try {
      // Отправляем POST запрос
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );
      if(response.body.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при отправке данных. Код ошибки: ${response.statusCode}'),
          ),
        );
      }
      // Проверяем статус ответа
      else if (response.statusCode == 200) {
        // Navigate to ResponsePage and pass response data
        print(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResponsePage(responseData: jsonDecode(response.body)),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при отправке данных. Код ошибки: ${response.statusCode}'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка при отправке запроса: $error'),
        ),
      );
    }
  }

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
              Image.asset("assets/image/Logo.png", width: sizeLogo, height: sizeLogo,),
              SizedBox(width: 10),
              Text('Выбери язык: $_selectedLanguage', style: TextStyle(fontSize: 18.0),),
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
                backgroundImage: AssetImage('assets/image/avatarka.png',),
              ),
            ),
            SizedBox(width: 25,),
          ],
        ),
      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Имя'),
            ),
            TextField(
              controller: _surnameController,
              decoration: InputDecoration(labelText: 'Фамилия'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                sendDataToAPI(context);
              },
              child: Text('Отправить данные'),
            ),
            ElevatedButton(
              onPressed: (){

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ));
              },
              child: Text('log in'),
            ),
          ],
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
        Navigator.pop(context); // Close the dialog
      },
    );
  }
}
