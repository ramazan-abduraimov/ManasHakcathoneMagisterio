// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
//
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _surnameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//
//   Future<void> sendDataToAPI() async {
//     // Создаем тело запроса
//     Map<String, String> data = {
//       'name': _nameController.text,
//       'surname': _surnameController.text,
//       'gmail': _emailController.text,
//       'role': 'user'
//     };
//
//     // Конвертируем данные в формат JSON
//     String requestBody = jsonEncode(data);
//
//     // URL API
//     String apiUrl = 'http://192.168.99.79:8080/api/data12';
//
//     try {
//       // Отправляем POST запрос
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: requestBody,
//       );
//
//       // Проверяем статус ответа
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Данные успешно отправлены.'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Ошибка при отправке данных. Код ошибки: ${response.statusCode}'),
//           ),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Ошибка при отправке запроса: $error'),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('API POST Request Example'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Имя'),
//             ),
//             TextField(
//               controller: _surnameController,
//               decoration: InputDecoration(labelText: 'Фамилия'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: sendDataToAPI,
//               child: Text('Отправить данные'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
