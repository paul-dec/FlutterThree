import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Role {
  final String status;
  const Role(this.status);
}

class MainPage extends StatefulWidget {
  final User user;
  final String role;
  final List z;

  // const MainPage({required this.user, required this.role});
  const MainPage({Key? key, required this.user, required this.role, required this.z}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  late User _currentUser;
  late String _currentRole;
  late List _z;

  @override
  initState() {
    _currentUser = widget.user;
    _currentRole = widget.role;
    _z = widget.z;
    // checkUsers();
    super.initState();
  }

  // Future<void> checkUsers() async {
  //   var z = <Map>[];
  //
  //   await FirebaseFirestore.instance.collection("users").get().then(
  //         (value) {
  //       for (var element in value.docs) {
  //         var userDetails = {};
  //         userDetails['id'] = element.id;
  //         userDetails['name'] = element.data()['name'];
  //         userDetails['role'] = element.data()['role'];
  //         userDetails['NFT'] = element.data()['NFT'];
  //         z.add(userDetails);
  //       }
  //     },
  //   );
  //   _userList = z;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_currentRole + ' Hello ${_currentUser.email}'),
        ),
        body:
          ListView(
            children: ListTile.divideTiles(
                color: Colors.deepPurple,
                tiles: _z.map((item) => ListTile(
                  title: Text(item['name']),
                  subtitle: Text(item['role']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {},
                  ),
            ))).toList()
          )
        );
        // StreamBuilder<QuerySnapshot>(
        //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else {
        //         return ListView.builder(
        //             itemBuilder: (BuildContext context, int index) {
        //               snapshot.data?.docs.map((document) {
        //                 return ListTile(
        //                   title: Text(document['name'].toString()),
        //                   // subtitle: Text(document['count'].toString())
        //                 );
        //               }).toList();
        //             },
        //         );
        //       }
        //     }
        // );
        // StreamBuilder<DocumentSnapshot>(
        //   stream: FirebaseFirestore.instance.collection('users').doc(_currentUser.uid).snapshots(),
        //   builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Text('Error: ${snapshot.error}');
        //     }
        //     switch(snapshot.connectionState) {
        //       case ConnectionState.waiting: return const Text('Loading...');
        //       default:
        //         return Text(snapshot.data?['name']);
        //     }
        //   },
        // ),
  }
}