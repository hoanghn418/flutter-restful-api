import 'package:flutter/material.dart';
import 'package:flutter_api/ui/details_page.dart';

import '../api/api_client.dart';
import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Post>> _postData;

  @override
  void initState() {
    super.initState();
    _postData = ApiClient.instance.getPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: FutureBuilder<List<Post>>(
            future: _postData,
            initialData: const [],
            builder: (
              BuildContext context,
              AsyncSnapshot<List<Post>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: _buildList(snapshot.data ?? []),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return _buildList(snapshot.data ?? []);
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<Post> postList) => ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) => Card(
          elevation: 6,
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Text(postList[index].id.toString()),
            ),
            title: Text(
              postList[index].title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              postList[index].body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deletePostItem(postList[index].id);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    title: 'Flutter Demo Details Page',
                    postId: postList[index].id,
                  ),
                ),
              );
            },
          ),
        ),
      );

  void _deletePostItem(int postId) {}
}
