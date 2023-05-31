import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/Models/MealDetail.dart';
import 'package:responsi/Network/ApiDataSource.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({super.key, required this.mealId});
  final String mealId;
  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  Future<void> _urlLaunch(String url) async {
    try {
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launc ${url}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: ApiDataSource.instance.getDetail(widget.mealId),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              MealDetail meal = MealDetail.fromJson(snapshot.data);
              return _buildDetail(meal.meals[0]);
            }
            if (snapshot.hasError) {
              return _buildError();
            }
            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildDetail(Map<String, dynamic> meal) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            meal["strMeal"],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 240,
            height: 240,
            child: Image.network(
              meal["strMealThumb"],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Category',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            meal["strCategory"],
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Area',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            meal["strArea"],
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Instruction',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            meal["strInstructions"],
            style: TextStyle(
              height: 1.5,
              fontSize: 15,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                _urlLaunch(meal["strYoutube"]);
              },
              child: Text('Watch on Youtube'))
        ],
      ),
    );
  }

  Widget _buildError() {
    return const Center(
      child: Text('Error'),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
