import 'package:flutter/material.dart';

import '../api/api_client.dart';
import '../models/post.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.title,
    required this.postId,
  }) : super(key: key);

  final String title;
  final int postId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<Post> _postData;

  @override
  void initState() {
    super.initState();
    _postData = ApiClient.instance.getDetailsPost(widget.postId);
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
          child: FutureBuilder<Post>(
            future: _postData,
            initialData: null,
            builder: (
              BuildContext context,
              AsyncSnapshot<Post> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: _buildContent(snapshot.data),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return _buildContent(snapshot.data);
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

  Widget _buildContent(Post? post) {
    final textTheme = Theme.of(context).textTheme;
    return post != null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: textTheme.headline6,
                ),
                const SizedBox(height: 12),
                Text(
                  post.body,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          )
        : Center(
            child: Text(
              'Empty data!!!',
              style: textTheme.headline6,
            ),
          );
  }
}
