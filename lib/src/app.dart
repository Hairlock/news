import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  Widget build(conext) {
    return StoriesProvider(
      child: CommentsProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    return settings.name == '/'
        ? MaterialPageRoute(
            builder: (context) {
              final bloc = StoriesProvider.of(context);
              bloc.fetchTopIds();

              return NewsList();
            },
          )
        : MaterialPageRoute(
            builder: (context) {
              final bloc = CommentsProvider.of(context);
              final itemId = int.parse(settings.name.replaceFirst('/', ''));

              bloc.fetchItemWithComments(itemId);

              return NewsDetail(
                itemId: itemId,
              );
            },
          );
  }
}
