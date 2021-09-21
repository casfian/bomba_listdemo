import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'photo.dart'; //guna sebagai alias http

class ListPhotos extends StatelessWidget {
  ListPhotos({Key? key}) : super(key: key);

  List<dynamic> photos = []; //awalan data sifar

  var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');

  Future<List<dynamic>> getPhotos() async {
    var data = await http.get(url);
    var jsonData = json.decode(data.body);

    //loop dan masukkan ke array
    for (var u in jsonData) {
      //sekali loop dia tambah data ke photo ke dalam photos array
      Photo photo = Photo(u!['index'], u['albumid'], u['id'], u['title'],
          u['url'], u['thumbnailUrl']);
      photos.add(photo);
    }
    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Photos'),
      ),
      body: ListView.builder(itemBuilder: itemBuilder),
    );
  }
}
