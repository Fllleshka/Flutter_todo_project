import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        ),
        body: Column(
          children: [
            Text('Главный экран',
              style: TextStyle(
                color: Colors.white,
              ),),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/todo');
              },
              child: Text('Перейти далее'),
            )
          ],
        )
    );
  }
}
