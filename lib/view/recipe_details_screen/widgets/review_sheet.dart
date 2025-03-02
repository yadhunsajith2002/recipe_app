import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';

class ReviewsBottomSheet extends StatelessWidget {
  final String recipeId;

  ReviewsBottomSheet({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6, // Adjust height
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reviews",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(child: _buildCommentsList(recipeId)),
        ],
      ),
    );
  }

  Widget _buildCommentsList(String recipeId) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection(tableRecipes)
              .doc(recipeId)
              .collection(tableComments)
              .orderBy("timestamp", descending: true) // Newest first
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No comments yet."));
        }

        var comments = snapshot.data!.docs;

        return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            var commentData = comments[index].data() as Map<String, dynamic>;
            return ListTile(
              leading: Icon(Icons.person, color: Colors.teal),
              title: Text(commentData[keyUserName] ?? "Anonymous"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(commentData[keyComments] ?? ""),
                  Row(
                    children: List.generate(
                      commentData[keyRatings] ?? 0,
                      (index) =>
                          Icon(Icons.star, color: Colors.amber, size: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
