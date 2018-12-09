import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import 'package:html_unescape/html_unescape.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }

          final comment = snapshot.data;
          final children = <Widget>[
            ListTile(
              title: _buildCommentText(comment),
              subtitle: Text(comment.by == '' ? 'Deleted' : comment.by),
              contentPadding: EdgeInsets.only(
                right: 16.0,
                left: depth * 16.0,
              ),
            ),
            Divider(),
          ];
          comment.kids.forEach((kidId) {
            children.add(
              Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth + 1,
              ),
            );
          });

          return Column(
            children: children,
          );
        });
  }

  _buildCommentText(ItemModel comment) {
    final unescape = new HtmlUnescape();
    final text = unescape.convert(comment.text);
    // final text = comment.text
    //     .replaceAll('&#x27;', "'")
    //     .replaceAll('<p>', '\n\n')
    //     .replaceAll('</p>', '');

    return Text(text);
  }
}
