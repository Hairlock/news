import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/comment.dart';
import '../blocs/comments_provider.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({this.itemId});

  Widget build(context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: _buildBody(bloc),
    );
  }

  Widget _buildBody(CommentsBloc bloc) {
    return StreamBuilder(
        stream: bloc.itemWithComments,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          return !snapshot.hasData
              ? Text('Loading')
              : FutureBuilder(
                  future: snapshot.data[itemId],
                  builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                    return !itemSnapshot.hasData
                        ? Text('Loading')
                        : _buildList(itemSnapshot.data, snapshot.data);
                  });
        });
  }

  Widget _buildList(ItemModel story, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(_buildTitle(story));
    final commentsList = story.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 1,
      );
    }).toList();
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget _buildTitle(ItemModel story) {
    return Container(
        margin: EdgeInsets.all(10.0),
        alignment: Alignment.topCenter,
        child: Text(
          story.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
