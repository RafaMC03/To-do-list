import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To do list'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<List<User>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('ERRO: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final users = snapshot.data!;

                return ListView(
                  children: users.map(buildUser).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

//Classes e Widgets

  Widget buildUser(User user) => ListTile(
        leading: IconButton(
          onPressed: () {
            final docUser =
                FirebaseFirestore.instance.collection('users').doc(user.id);

            docUser.delete();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.black,
          ),
        ),
        title: Center(child: Text(user.atv)),
        subtitle: Center(child: Text(user.desc)),
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Register(
                          edit: user,
                        )));
          },
          icon: const Icon(Icons.edit, color: Colors.black),
        ),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            print(doc.data());
            return User.fromJson(doc.data());
          }).toList());
}

class User {
  String id;
  final String atv;
  final String desc;

  User(
    this.atv,
    this.desc, {
    this.id = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'atv': atv,
        'desc': desc,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        json['atv'],
        json['desc'],
        id: json['id'],
      );
}
