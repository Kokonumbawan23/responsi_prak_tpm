import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/Models/Meal.dart';
import 'package:responsi/Network/ApiDataSource.dart';
import 'package:responsi/Models/Category.dart';
import 'package:responsi/View/Meals.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal Categories',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ApiDataSource.instance.getCategory(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              CategoryWrapper categories =
                  CategoryWrapper.fromJson(snapshot.data);
              return _buildCategories(categories);
            }
            if (snapshot.hasError) {
              return _buildError();
            }
            return _buildLoading();
          }),
    );
  }

  Widget _buildCategories(CategoryWrapper category) {
    return ListView.builder(
      itemCount: category.categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Meals(mealName: category.categories[index].strCategory))),
          child: Card(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: Image.network(
                      category.categories[index].strCategoryThumb),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  category.categories[index].strCategory,
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
