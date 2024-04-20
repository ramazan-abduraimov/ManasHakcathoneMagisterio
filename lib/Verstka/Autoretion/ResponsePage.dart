import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:magisteria/Verstka/ForumSentCheck.dart';

class ResponsePage extends StatelessWidget {
  final Map<String,dynamic> responseData;

  const ResponsePage({Key? key, required this.responseData,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Response Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoContainer('First Name', responseData['name']),
              SizedBox(height: 16.0),
              _buildInfoContainer('Last Name', responseData['surname']),
              SizedBox(height: 16.0),
              _buildInfoContainer('Email', responseData['gmail']),

              SizedBox(height: 20,),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(184, 9, 36, 1.0),
                    ),
                    foregroundColor:
                    MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(350, 50)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  onPressed: ()
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ForumSentCheck(),
                    ));
                  },
                  child: Text(
                    "Successfully",
                    style: TextStyle(fontSize: 18),
                  )),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String label, String? value) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            value ?? "Пусто",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
