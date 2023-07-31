import 'package:flutter/material.dart';
import 'package:tareas/constants/constant.dart';
import 'package:tareas/domain/models/news_model.dart';
import 'package:tareas/presentation/blocs/connecty/connecty/connecty_bloc.dart';
import 'package:tareas/presentation/blocs/news/news_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tareas/presentation/pages/home/news/news_detail_page.dart';

import '../../../utils/colors.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsBloc newsBloc;
  String selectedCountry = 'us'; // País inicialmente seleccionado
  String? _selectedRadioListTile;

  @override
  void initState() {
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.getListNews();
  }

  @override
  void dispose() {
    newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorblackLite,
          centerTitle: true,
          title: Text("Noticias",style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold),
            )),
        backgroundColor: colorblackLite,
        body: BlocBuilder<ConnectyBloc, ConnectyState>(
          builder: (context, state) {
            return !state.isAllGranted
                ? SafeArea(
                    child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 4, top: 4),
                          child: filterCuontry(),
                        ),
                        _newsList(context)
                      ],
                    ),
                  ))
                : Text("mario fernando ");
          },
        ));
  }

  Widget filterCuontry() {
    return Container(
      color: colorPrimary,
      margin: EdgeInsets.only(left: 1, right: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpansionTile(
            collapsedIconColor: colorSecundary,
            collapsedTextColor: colorThree,
            backgroundColor: Colors.white,
            textColor: colorPrimary,
            title: const Text(
              'Informacón de paises ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold),
            ),
            children: [
              RadioListTile<String>(
                activeColor: colorSecundary,
                title: Text(
                  'Colombia',
                  style: TextStyle(color: colorFour),
                ),
                value: AppConstants.CountryColombia,
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    newsBloc.add(FilterNewCountryEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
              RadioListTile<String>(
                activeColor: colorSecundary,
                title: Text(
                  'Estados Unidos',
                  style: TextStyle(color: colorFour),
                ),
                value: AppConstants.CountryUSA,
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    newsBloc.add(FilterNewCountryEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
              RadioListTile<String>(
                activeColor: colorSecundary,
                title: Text(
                  'Japon',
                  style: TextStyle(color: colorFour),
                ),
                value: AppConstants.CountryJAPAN,
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    newsBloc.add(FilterNewCountryEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
              RadioListTile<String>(
                activeColor: colorSecundary,
                title: Text(
                  'México',
                  style: TextStyle(color: colorFour),
                ),
                value: AppConstants.CountryMEXICO,
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    newsBloc.add(FilterNewCountryEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _newsList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 2,
        right: 2,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.77,
        child: StreamBuilder<List<Article>>(
          stream: newsBloc.newsController,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final pro = snapshot.data!;
              if (pro.length > 0) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: pro.length,
                    itemBuilder: (context, index) {
                      final news = pro[index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [listNews(news)],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/cero-items.png'),
                        width: 140,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "No se encontró ninguna noticas",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ));
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar los noticias'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget listNews(Article news) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppConstants.detailNewPage,
            arguments: news),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  news.urlToImage ?? 'https://via.placeholder.com/150',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  news.title ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: Text(
                  "Fuente ${news.source?.name}",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
