import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'photo.dart'; //guna sebagai alias http

class ListPhotos extends StatefulWidget {
  ListPhotos({Key? key}) : super(key: key);

  @override
  _ListPhotosState createState() => _ListPhotosState();
}

class _ListPhotosState extends State<ListPhotos> {
  List<dynamic> photos = [];
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
    photos = jsonData;
    print(photos);
    return photos;
  }

  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Photos'),
      ),
      body: FutureBuilder(
          future: getPhotos(), //sumber data
          builder: (context, AsyncSnapshot snapshot) {
            //check connection dulu
            if (snapshot.connectionState == ConnectionState.done) {
              //paparkan data
              return ListView.builder(
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(snapshot.data[index]['thumbnailUrl']),
                      title: Text(snapshot.data[index]['title']),
                      subtitle: Text(snapshot.data[index]['url']),
                    );
                  });
            } else {
              //tunjuk sesuatu supaya user tau data tengah loading
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
