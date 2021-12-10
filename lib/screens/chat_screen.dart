import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/BcbI6mOt94XhvfB0StNQ/messages')
            .snapshots(),
        builder: (ctx, streamSnapShot) {
          if (streamSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapShot.data as QuerySnapshot;
          //final doc = streamSnapShot as dynamic;
          return ListView.builder(
            itemCount: documents.docs.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents.docs[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/BcbI6mOt94XhvfB0StNQ/messages')
              .add({'text': 'This was added by clicking the button!'});
        },
      ),
    );
  }
}
