
import 'package:flutter/material.dart';
import 'package:magisteria/Verstka/Autoretion/SentInfo.dart';
import 'package:magisteria/Verstka/ForumSentCheck.dart';

class BolumInfo  extends StatefulWidget {
  const BolumInfo ({Key? key}) : super(key: key);

  @override
  State<BolumInfo> createState() => _BolumInfoState();
}

class _BolumInfoState extends State<BolumInfo> {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70), // задаем высоту аппбара
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
                  offset: Offset(1, 1), // смещение тени по горизонтали и вертикали
                ),
              ],
            ),
          ),
          title: Row(
            children: [
              Image.asset("assets/image/Logo.png", width: sizeLogo,height: sizeLogo,), // Эмблема
              SizedBox(width: 10), // Отступ
              Text('Выбери язык: $_selectedLanguage', style: TextStyle(fontSize: 18.0),),
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
                backgroundImage: AssetImage('assets/image/avatarka.png',),
              ),
            ),
            SizedBox(width: 25,),
          ],

        ),),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset("assets/image/engenering3.jpg",),
          Padding(
            padding: const EdgeInsets.only(top: 15,left: 20),
            child: Row(
              children: [
                Text("История",style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
         Padding(
           padding: const EdgeInsets.only(left: 20,right: 20),
           child: Container(child: Text("Отделение программной инженерии специализируется на подготовке специалистов по разработке программного обеспечения и новейших технологий программирования. В отделении с 1997 года готовят бакалавров, с 2006 года магистров, а с 2015 года открыта подготовка PhD по направлению программной инженерии." ),),
         ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 20),
            child: Row(
              children: [
                Text("Основные предметы ",style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
            child: Container(child: Text("Предметы отделения ведутся с первого курса, а с третьего курса преподаются специализированные предметы, такие как: Введение в компьютерную инженерию, Информатика, Алгоритмы и база данных, Языки программирования, Структурное программирование, Объектно-Ориентированное Программирование, Компьютерная графика, Электрические цепи, Статистика и Теория Вероятности, Инженерное программирование, Системы управления данными, Проектирование логических схем, Коммуникация и компьютерная отрасль, Искусственный интеллект и экспертные системы, Введение в операционную систему, Информация и компьютерная безопасность, Безопасность жизнедеятельности, Компьютерная архитектура, Системное программирование, Инженерная экономика, Проект и архитектура программного обеспечения. Кроме этих предметов, выпускники обязательно должны получить еще 12 предметов по выбору. На четвертом курсе выпускники бакалавриата работают над выпускной квалификационной (дипломной) работой и защищаются перед государственной комиссией.Студенты, успешно окончившие бакалавриат, могут поступить в магистратуру, где первый год обучения состоит из четырех обязательных предметов и шести курсов по выбору. Последние два года магистрант работает над исследовательским проектом, публикует научную статью и защищается.Время обучения на докторантуре длится четыре года и состоит из курсов по выбору. Последние 3 года обучения выделяются на сдачу экзаменов по специальности и на научно-исследовательскую работу. После публикации работы по программе PhD докторант защищает свою работу перед специальной комиссией и в случае успешной защиты ему присваивается степень PhD." ),),
          ),
          Stack(children: [
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
                    builder: (BuildContext context) => SentInfo(),
                  ));
                },
                child: Text(
                  "Apply Now ",
                  style: TextStyle(fontSize: 18),
                )),
          ],
          ),
          SizedBox(height: 25,),
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



