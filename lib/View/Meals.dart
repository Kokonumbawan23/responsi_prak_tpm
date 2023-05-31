import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/Models/Meal.dart';
import 'package:responsi/Network/ApiDataSource.dart';
import 'package:responsi/View/MealDetails.dart';

class Meals extends StatefulWidget {
  const Meals({super.key, required this.mealName});
  final String mealName;
  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.getMeals(widget.mealName),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            Meal meal = Meal.fromJson(snapshot.data);
            return _buildMeals(meal);
          }
          if (snapshot.hasError) {
            return _buildError();
          }
          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildMeals(Meal meal) {
    return ListView.builder(
      itemCount: meal.meals.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MealDetails(
                        mealId: meal.meals[index].idMeal,
                      ))),
          child: Card(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: Image.network(meal.meals[index].strMealThumb),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  meal.meals[index].strMeal,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
              ],
            ),
          )),
        );
      },
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
