import 'package:flutter/material.dart';
import 'package:shobek/src/Models/post/search_model.dart';
import 'package:shobek/src/Provider/post/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Provider/checkProvider.dart';

class CustomSearchBar extends StatefulWidget {
  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController controller = new TextEditingController();
  SearchModel model;
  String errorMessage;
  SearchProvider searchProvider;
  bool isLoading = false;
  List<Search> results;
  bool isInit = true;
  String query = "";
  @override
  void initState() {
    controller.addListener(() {
      if (controller.text.trim().isEmpty) {
        if (errorMessage != null) {
          setState(() {
            errorMessage = null;
          });
        }
        if (isLoading) {
          setState(() {
            isLoading = false;
          });
          if (model != null) {
            setState(() {
              model = null;
            });
          }
        }
        if (model != null) {
          setState(() {
            model = null;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> searchByKeyword(String keyword) async {
    if (keyword.isNotEmpty) {
      model = await Provider.of<SearchProvider>(context, listen: false)
          .search(keyword, context);
      searchProvider = Provider.of<SearchProvider>(context, listen: false);
      results =
          searchProvider.shops;
      if (model.data == null) {
        errorMessage = model.error[0].value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 35),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  color: Colors.white,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            controller: controller,
                            textDirection: TextDirection.rtl,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.right,
                            textInputAction: TextInputAction.search,
                            onFieldSubmitted: (v) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              hintText: "ابحث عن كل ما تحتاجه",
                            ),
                            onChanged: (value) async {
                              setState(() {
                                query = value.trim();
                              });
                              if (value.trim().isEmpty) {
                                setState(() {
                                  if (results != null) {
                                    results.clear();
                                  }
                                });
                              } else {
                                await searchByKeyword(value.trim());
                              }

                              Provider.of<CheckProvider>(context, listen: false)
                                  .searchResult(
                                      controllerPamter: controller,
                                      searchResultsparmter: results,
                                      errorMessagePramter: errorMessage,
                                      isLoadingParmter: isLoading);
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: query != ''
                                ? IconButton(
                                    icon: Icon(
                                      Icons.close,
                                    ),
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        controller.clear();
                                      });
                                      setState(() {
                                        errorMessage = null;
                                        results.clear();
                                        isLoading = false;
                                        query = '';
                                      });

                                      Provider.of<CheckProvider>(context,
                                              listen: false)
                                          .searchResult(
                                              controllerPamter: controller,
                                              searchResultsparmter: results,
                                              errorMessagePramter: errorMessage,
                                              isLoadingParmter: isLoading);
                                    },
                                  )
                                : Icon(
                                    Icons.search,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
