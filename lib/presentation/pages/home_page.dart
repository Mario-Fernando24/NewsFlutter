import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tareas/presentation/blocs/connecty/connecty/connecty_bloc.dart';
import 'package:tareas/presentation/pages/home/news/news_page.dart';
import 'package:tareas/presentation/pages/home/news_save/new_save_page.dart';
import 'package:tareas/presentation/utils/colors.dart';

import '../utils/custom_animated_bottom_bar.dart';

class HomePageNews extends StatefulWidget {
  const HomePageNews({super.key});

  @override
  State<HomePageNews> createState() => _HomePageNewsState();
}

class _HomePageNewsState extends State<HomePageNews> {
  late ConnectyBloc connectyBloc;

  @override
  void initState() {
    super.initState();
    connectyBloc = BlocProvider.of<ConnectyBloc>(context);
    connectyBloc.connected(context);
  }

  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
            Container(color: colorblackLite, child: _bottonBar()),
        body: Center(
          child: StreamBuilder<bool>(
            stream: connectyBloc
                .connectyStreamsssss, 
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return  IndexedStack(
                        index: value, children: [NewsPage(), NewsSavePage()]);
                   
              } else {
                
                return Text('Esperando eventos...');
              }
            },
          ),
        )
        );
  }

  Widget _bottonBar() {
    int a;
    return GestureDetector(
      child: CustomAnimatedBottomBar(
          containerHeight: 60,
          backgroundColor: colorPrimary,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          selectedIndex: value,
          onItemSelected: (index) => {
                a = index,
                setState(() {
                  value = a.toInt();
                  connectyBloc.connected(context);
                }),
              },
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.article_outlined),
              title: Text("Noticias"),
              activeColor: colorThree,
              inactiveColor: colorSecundary,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.star),
              title: Text("Save"),
              activeColor: colorThree,
              inactiveColor: colorSecundary,
            ),
          ]),
    );
  }
}
