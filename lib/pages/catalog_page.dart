// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Project imports:
import 'package:rshb_test/models/category.dart';
import 'package:rshb_test/models/product.dart';
import 'package:rshb_test/pages/product_page.dart';
import 'package:rshb_test/services/helpers.dart';
import 'package:rshb_test/services/rshb_icons.dart';
import 'package:rshb_test/widgets/rating_box.dart';
import 'package:rshb_test/widgets/round_icon_button.dart';

class CatalogPage extends StatefulWidget {
  static const routeName = 'catalog';

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  var tabs = <Tab>[];
  bool isSortActive = false;
  var activeFilters = <Category>[Category.bread, Category.eggs];
  bool get isFavorite =>
      Random(DateTime.now().millisecondsSinceEpoch).nextInt(2) == 1;
  final product = Product.fromJson(productJsonExample);

  @override
  void initState() {
    tabs = [_buildTab('Продукты'), _buildTab('Фермеры'), _buildTab('Агротуры')];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                elevation: 8,
                shadowColor: Colors.grey[50],
                backgroundColor: Colors.white,
                leading: Icon(Icons.arrow_back),
                title: Text(
                  'Каталог',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                )),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomScrollView(slivers: [
                  SliverPersistentHeader(
                    delegate: FilterDelegate(content: _buildAppBarContent()),
                    floating: true,
                  ),
                  SliverPadding(
                      padding: EdgeInsets.only(bottom: 20),
                      sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  _buildGridItem(context, index),
                              childCount: 6),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.55))),
                ]))));
  }

  Tab _buildTab(String title) => Tab(
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: Text(title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))));

  Widget _buildFilterButton(
      {@required IconData iconData,
      @required VoidCallback onPressed,
      @required String text,
      bool isActive = false}) {
    return Column(children: [
      RoundIconButton(
        iconData: iconData,
        onPressed: onPressed,
        isActive: isActive,
      ),
      SizedBox(height: 8),
      SizedBox(
          width: 80,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ))
    ]);
  }

  Widget _buildAppBarContent() {
    return Container(
        padding: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Column(children: [
          Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(60)),
              child: TabBar(
                  onTap: (val) => print(val),
                  tabs: tabs,
                  unselectedLabelColor: Colors.black87,
                  indicator: BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green))),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterButton(
                      iconData: RshbIcons.sort,
                      onPressed: () => print('filter sort pressed'),
                      text: 'Сортировать',
                      isActive: isSortActive),
                  _buildFilterButton(
                      iconData: RshbIcons.vegetables,
                      onPressed: () =>
                          print('filter ${Category.vegetables} pressed'),
                      text: 'Овощи и фрукты',
                      isActive: activeFilters.contains(Category.vegetables)),
                  _buildFilterButton(
                      iconData: RshbIcons.bread,
                      onPressed: () =>
                          print('filter ${Category.bread} pressed'),
                      text: 'Хлеб и выпечка',
                      isActive: activeFilters.contains(Category.bread)),
                  _buildFilterButton(
                      iconData: RshbIcons.eggs,
                      onPressed: () => print('filter ${Category.eggs} pressed'),
                      text: 'Молоко и яица',
                      isActive: activeFilters.contains(Category.eggs)),
                  _buildFilterButton(
                      iconData: RshbIcons.meat,
                      onPressed: () => print('filter ${Category.meat} pressed'),
                      text: 'Мясо',
                      isActive: activeFilters.contains(Category.meat))
                ],
              )),
        ]));
  }

  Widget _buildGridItem(BuildContext context, int index) {
    return InkWell(
        onTap: () => Navigator.of(context).pushNamed(ProductPage.routeName),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[400])),
            child: Stack(children: [
              Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: SizedBox(
                      width: double.infinity,
                      height: (MediaQuery.of(context).size.width / 2 - 21) /
                          0.55 *
                          0.4,
                      child: Image.asset(product.image, fit: BoxFit.cover)),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Row(children: [
                            Text(product.title,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                            Text(' / ${product.unit}',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey))
                          ]),
                          SizedBox(height: 25),
                          Row(children: [
                            RatingBox(product.rating),
                            Text(
                                '${product.ratingCount} ' +
                                    selectWordFormByNum(
                                        ['оценка', 'оценки', 'оценок'],
                                        product.ratingCount),
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey))
                          ]),
                          SizedBox(height: 15),
                          Text(
                            product.shortDescription,
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 15),
                          Text(product.farmer,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w400)),
                          SizedBox(height: 15),
                          Text('${product.price} ₽',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600))
                        ]))
              ]),
              Positioned(
                right: 10,
                top: 10,
                child: RoundIconButton(
                  iconData: isFavorite
                      ? RshbIcons.bookmark_active
                      : RshbIcons.bookmark,
                  onPressed: () => print('add to favofite'),
                  isActive: isFavorite,
                  activeBackgroundColor: Colors.white,
                  activeIconColor: Colors.green,
                ),
              )
            ])));
  }
}

/// Переключение между табами и фильтры
class FilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget content;
  FilterDelegate({this.content});
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      content;

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
