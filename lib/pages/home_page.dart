import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/components/my_drawer.dart';
import 'package:minimal_social_media/components/my_list_tile.dart';
import 'package:minimal_social_media/components/my_post_button.dart';
import 'package:minimal_social_media/components/my_textfield.dart';

import '../database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController newPostController = TextEditingController();
  final FirestoreDatabase database = FirestoreDatabase();

  void postMessages() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    //clear controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text("W A L L"),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: "Say Something",
                      obscureText: false,
                      controller: newPostController),
                ),
                MyPostButton(onTap: postMessages)
              ],
            ),
          ),
          //READ
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                //loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                //get posts
                final posts = snapshot.data!.docs;

                //no data
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No posts.. Post Something"),
                    ),
                  );
                }

                //return as lists
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      //get each indi post
                      final post = posts[index];

                      //get data from each posts
                      String message = post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];

                      //return as list tile
                      return MyListTile(title: message, subtitle: userEmail);
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}
