import 'package:shobek/src/MainWidgets/filtterCard.dart';
import 'package:shobek/src/Provider/categorisFiltter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shobek/src/Provider/checkProvider.dart';
import 'package:shobek/src/Provider/post/productFiltterProvider.dart';

class CategoriesFiltter extends StatefulWidget {
  @override
  _CategoriesFiltterState createState() => _CategoriesFiltterState();
}

class _CategoriesFiltterState extends State<CategoriesFiltter> {
  @override
  void initState() {
    Future.delayed(Duration(microseconds: 150), () {
      Provider.of<CategoriesFiltterProvider>(context, listen: false)
          .getCategories(context);
    });
    checkProvider = Provider.of<CheckProvider>(context, listen: false);
    productFiltterProvider =
        Provider.of<ProductFiltterProvider>(context, listen: false);
    categoriesFiltterProvider =
        Provider.of<CategoriesFiltterProvider>(context, listen: false);
    all = true;
    categoryId = 0;
    super.initState();
  }

  CategoriesFiltterProvider categoriesFiltterProvider;
  CheckProvider checkProvider;
  ProductFiltterProvider productFiltterProvider;
  bool all;
  int categoryId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 3),
      child: Container(
        height: 50,
        child: AnimationLimiter(
          child: ListView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            children: [
              Filtter(
                onTap: () {
                  setState(() {
                    all = true;
                    categoryId = 0;
                  });
                  checkProvider.assignValueProduct(products: productFiltterProvider.products);
                  for (int i = 0;
                      i < categoriesFiltterProvider.categories.length;
                      i++) {
                    categoriesFiltterProvider.categories[i].selected = false;
                  }
                },
                backgroundColor: all
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).scaffoldBackgroundColor,
                title: 'الكل',
                elevation: all ? 3 : 0,
                titleColor:
                    all ? Theme.of(context).accentColor : Colors.black87,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: Provider.of<CategoriesFiltterProvider>(context,
                          listen: true)
                      .categories
                      .length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: Duration(milliseconds: 400),
                      child: SlideAnimation(
                        duration: Duration(milliseconds: 400),
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          child: Filtter(
                            title: categoriesFiltterProvider
                                .categories[index].name,
                            onTap: () {
                              setState(() {
                                all = false;

                                for (int i = 0;
                                    i <
                                        categoriesFiltterProvider
                                            .categories.length;
                                    i++) {
                                  if (i == index) {
                                    categoriesFiltterProvider
                                        .categories[i].selected = true;
                                    categoryId = categoriesFiltterProvider
                                        .categories[i].id;
                                  } else {
                                    categoriesFiltterProvider
                                        .categories[i].selected = false;
                                  }
                                }
                                checkProvider.assignValueProduct(products: productFiltterProvider
                                    .products
                                    .where((e) => e.categoryId == categoryId)
                                    .toList());
                              });
                            },
                            backgroundColor:
                                Provider.of<CategoriesFiltterProvider>(context,
                                            listen: true)
                                        .categories[index]
                                        .selected
                                    ? Theme.of(context).primaryColor
                                    : null,
                            elevation: Provider.of<CategoriesFiltterProvider>(
                                        context,
                                        listen: true)
                                    .categories[index]
                                    .selected
                                ? 3
                                : null,
                            titleColor: Provider.of<CategoriesFiltterProvider>(
                                        context,
                                        listen: true)
                                    .categories[index]
                                    .selected
                                ? Theme.of(context).accentColor
                                : Colors.black54,
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
