// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rshb_test/models/product.dart';
import 'package:rshb_test/services/helpers.dart';
import 'package:rshb_test/services/rshb_icons.dart';
import 'package:rshb_test/widgets/details_tile.dart';
import 'package:rshb_test/widgets/rating_box.dart';
import 'package:rshb_test/widgets/round_icon_button.dart';

class ProductPage extends StatefulWidget {
  static const routeName = 'product';
  static const charastericsPreviewCount = 5;
  ProductPage({Key key}) : super(key: key);

  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool get isFavorite =>
      Random(DateTime.now().millisecondsSinceEpoch).nextInt(2) == 1;
  bool showDetails = false;
  final product = Product.fromJson(productJsonExample);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: ProductInfoHeaderDelegate(
              imagePath: product.image,
              onPressed: () => print('add to favofite')),
        ),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: _buildProductInfo(product)))
      ]),
    );
  }

  Widget _buildProductInfo(Product product) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Column(children: [
          SizedBox(height: 8),
          Row(children: [
            Text(product.title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            Text(' / ${product.unit}',
                style: TextStyle(fontSize: 12, color: Colors.grey))
          ]),
          SizedBox(height: 12),
          Row(children: [
            RatingBox(product.rating),
            Text(
                '${product.ratingCount} ' +
                    selectWordFormByNum(
                        ['оценка', 'оценки', 'оценок'], product.ratingCount),
                style: TextStyle(fontSize: 12, color: Colors.grey))
          ]),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${product.price ?? '-'} ₽',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 40),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 56),
          ..._buildCharacteristics(product.characteristics),
          SizedBox(height: 20),
        ]));
  }

  List<Widget> _buildCharacteristics(List<Characteristic> characteristics) {
    if (characteristics == null) return [];
    var firstDetails = <Widget>[];
    var lastDetails = <Widget>[];
    for (var i = 0; i < characteristics.length; i++) {
      if (i < ProductPage.charastericsPreviewCount) {
        firstDetails.add(
            DetailsTile(characteristics[i].title, characteristics[i].value));
      } else {
        lastDetails.add(
            DetailsTile(characteristics[i].title, characteristics[i].value));
      }
    }
    if (lastDetails.isEmpty) return firstDetails;
    var result = firstDetails;

    result.add(AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 300),
        height: showDetails ? 0 : 30,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          child: Row(
            children: [
              Text(
                'Все характеристики',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: showDetails ? 0 : 24,
                color: Colors.green,
              )
            ],
          ),
          onTap: () => setState(() => showDetails = true),
        )));
    result.add(AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        height: showDetails
            ? (characteristics.length - ProductPage.charastericsPreviewCount) *
                32.0
            : 0,
        width: MediaQuery.of(context).size.width,
        child: Wrap(children: lastDetails)));
    result.add(AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 300),
        height: showDetails ? 30 : 0,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          child: Row(
            children: [
              Text(
                'Скрыть характеристики',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_up,
                size: showDetails ? 24 : 0,
                color: Colors.green,
              )
            ],
          ),
          onTap: () => setState(() => showDetails = false),
        )));
    return result;
  }
}

/// Верхняя часть страницы продукта с картинкой
class ProductInfoHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String imagePath;
  final VoidCallback onPressed;

  ProductInfoHeaderDelegate(
      {@required this.imagePath, @required this.onPressed});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool isFavorite = false;
    return Stack(children: [
      Container(
          width: double.infinity,
          height: 280,
          color: Colors.black.withOpacity(shrinkOffset / 500),
          child: Image.asset(imagePath,
              fit: BoxFit.fitWidth,
              color: Colors.black.withOpacity(shrinkOffset / 500),
              colorBlendMode: BlendMode.darken)),
      Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
          )),
      Positioned(
        top: MediaQuery.of(context).padding.top + 8,
        right: 16,
        child: RoundIconButton(
          iconData: isFavorite ? RshbIcons.bookmark_active : RshbIcons.bookmark,
          onPressed: onPressed,
          isActive: isFavorite,
          activeBackgroundColor: Colors.white,
          activeIconColor: Colors.green,
        ),
      ),
      Positioned(
        top: MediaQuery.of(context).padding.top + 8,
        left: 20,
        child: RoundIconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
      )
    ]);
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 104;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
