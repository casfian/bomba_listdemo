import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  Screen1({Key? key}) : super(key: key);
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  List pelakon = [
    'Ali Baba',
    'Kassim Baba',
    'Chief',
    'Penyamun1',
    'Penyamun2',
    'Penyamun3',
    'Penyamun4',
  ];

  final _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //function sini
    void inputNama() {
      print('input nama...');
      AlertDialog alert = AlertDialog(
        title: Text('Sila Masukkan Nama'),
        content: TextField(
          controller: _myController,
        ),
        actions: [
          TextButton(
              onPressed: () {
                pelakon.add(_myController.text);
                setState(() {
                  //ini akan trigger utk screen refresh
                });
                Navigator.pop(context);
              },
              child: Text('OK')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel')),
        ],
      );

      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen1'),
      ),
      body: ListView.builder(
        itemCount: pelakon.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(pelakon[index]),
            subtitle: Text('description...'),
            trailing: Icon(Icons.info),
            onTap: () {
              pelakon.removeAt(index);
              setState(() {
                //refresh screen
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          inputNama();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

/*
body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Ali Baba'),
            subtitle: Text('Saudagar kaya'),
            trailing: Icon(Icons.info),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Kassim Baba'),
            subtitle: Text('Abang Saudagar kaya'),
            trailing: Icon(Icons.info),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Chief'),
            subtitle: Text('Ketua Penyamun 40'),
            trailing: Icon(Icons.info),
          ),
        ],
      ),
    */