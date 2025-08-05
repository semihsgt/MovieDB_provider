import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moviedb_org/Pages/details_page.dart';
import 'package:moviedb_org/gitignore/api_constants.dart';
import 'package:moviedb_org/parseClasses/popular_movies.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<PopMovResults>?> popMovParse() async {
    var url = Uri.parse('https://api.themoviedb.org/3/movie/popular?language=en-US&page=1');
    var cevap = await http.get(
      url,
      headers: ApiConstants.headers,
    );
    return PopMov.fromJson(json.decode(cevap.body)).results;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE05A2B),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('/Users/semihsogut/StudioProjects/Flutter/moviedb/assets/images/app_icon.png', height: 50,),
            Text("MovieDB", style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: FutureBuilder(
        future: popMovParse(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final popMovs = snapshot.data;
            if (popMovs == null) {
              return Center(child: Text('Data Bulunamadi'));
            } else {
              return MovieListWidget(popMovs: popMovs);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          } 
        }
      ),
    );
  }
}

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({
    super.key,
    required this.popMovs,
  });

  final List<PopMovResults> popMovs;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.52
      ), 
      itemCount: popMovs.length,
      itemBuilder: (context, index) {
        final pm = popMovs[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(pm)));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.grey.shade800.withValues(colorSpace: ColorSpace.sRGB),
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network('https://image.tmdb.org/t/p/w1280${pm.posterPath}'),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8.0),
                    child: Text(pm.title ?? "", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  ),
                  Spacer(),
                  Text('${pm.releaseDate}'),
                  Spacer(),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

//provider eklenecek
//navigation bar + favorites tab
//favorite heart button