
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:magisteria/Verstka/BolumInfo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedLanguage = 'English';

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    // Implement logic to change the app's language based on the selected option
    // For demonstration purposes, we are only updating the UI
    print('Language changed to: $language');
  }
  double sizeLogo = 45;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        PreferredSize(
        preferredSize: Size.fromHeight(70), // задаем высоту аппбара
        child: AppBar(

        flexibleSpace: Container(

          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(1, 1), // смещение тени по горизонтали и вертикали
              ),
            ],
          ),
        ),
        title: Row(
          children: [
            Image.asset("assets/image/Logo.png", width: sizeLogo,height: sizeLogo,), // Эмблема
            SizedBox(width: 10), // Отступ
            Text('Выбери язык: $_selectedLanguage', style: TextStyle(fontSize: 20.0),),
            // Заголовок
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
              backgroundImage: AssetImage('assets/image/avatarka.png'),
            ),
          ),
          SizedBox(width: 25,),
        ],

      ),),

      body: Column(
        children: [

          SizedBox(height: 20,),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => BolumInfo(),
                        ));
                      },
                      child: Container(
                        height: 200,
                        width: 350,
                      
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(1, 1), // смещение тени по горизонтали и вертикали
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                      
                            SizedBox(height: 20,),
                      
                          ],),
                      
                      ),
                    ),
                    SizedBox(height: 30,),
                    GestureDetector(
                      child: Container(
                        height: 200,
                        width: 350,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(1, 1), // смещение тени по горизонтали и вертикали
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height: 20,),

                          ],),

                      ),
                    ),
                    SizedBox(height: 30,),

                    GestureDetector(
                      child: Container(
                        height: 200,
                        width: 350,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(1, 1), // смещение тени по горизонтали и вертикали
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height: 20,),

                          ],),

                      ),
                    ),
                    SizedBox(height: 30,),

                    GestureDetector(
                      child: Container(
                        height: 200,
                        width: 350,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(1, 1), // смещение тени по горизонтали и вертикали
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height: 20,),

                          ],),

                      ),
                    ),
                    SizedBox(height: 30,),



                  ],
                ),

              ],
            ),
          ),
        ],
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
