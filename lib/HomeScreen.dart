import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/flipcard.dart';
import 'package:flutter_application_1/photo.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late ScaffoldMessengerState _scaffoldMessengerState;
  List<Photo> _photos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addComment("This is your first comment");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
  }

  Future<void> fetchPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<Photo> fetchedPhotos =
          jsonList.map((json) => Photo.fromJson(json)).toList();

      setState(() {
        _photos = fetchedPhotos;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> _addComment(String comment) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/photos/1');

    final response = await http.put(
      url,
      body: jsonEncode({
        'id': 1,
        'title': comment,
        'thumbnailUrl':
            'https://www.google.com/s2/favicons?sz=64&domain_url=yahoo.com',
        'url': 'https://yahoo.com',
      }),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      final Photo newPhoto = Photo.fromJson(json);

      setState(() {
        _photos.add(newPhoto);
      });

      _scaffoldMessengerState.showSnackBar(
        SnackBar(
          content: Text(
            'Comment added successfully',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.purple.shade100,
        ),
      );
    } else {
      print('Request failed with status: ${response.statusCode}.');

      _scaffoldMessengerState.showSnackBar(
        SnackBar(content: Text('Failed to add comment')),
      );
    }
  }

  void showdialoge(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String comment = '';

        return AlertDialog(
          title: Text("Type Below"),
          content: TextField(
            onChanged: (value) {
              comment = value;
            },
            decoration: InputDecoration(
              hintText: 'Comment',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addComment(comment);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(_photos.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Comments",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          flipcard(
            size: size,
            cVV: "123",
            cardName: "Shivam karoria",
            cardNumber: "5252 5252 5252 5252",
            expDate: "12/06",
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Search...',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(_photos[index].thumbnailUrl),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          _photos[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showdialoge(context); // Show the AlertDialog
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          child: _photos.length - 1 == index
                              ? Icon(Icons.add)
                              : Icon(Icons.check),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
