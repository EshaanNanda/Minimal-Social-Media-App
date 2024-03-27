import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/components/my_list_tile.dart';
import 'package:minimal_social_media/helper/helper_func.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            // Handle errors more gracefully
            displayMessageToUser("Something went wrong", context);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while data is being fetched
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            // Provide a message when there's no data
            return Center(
              child: Text("No users found"),
            );
          }

          // Get the list of users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    // Get individual user
                    final user = users[index].data() as Map<String, dynamic>;
                    String username = user['username'];
                    String email = user['email'];

                    // Use document ID as a unique key
                    String userId = users[index].id;

                    return MyListTile(
                      key: Key(userId),
                      title: username,
                      subtitle: email,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
