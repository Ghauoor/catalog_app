import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter_catalog/pages/home_details_page.dart';

import '../../models/catalog.dart';
import 'add_to_cart.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !context.isMobile
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20.0),
            shrinkWrap: true,
            itemCount: CatalogModel.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModel.items[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeDetailPage(catalog: catalog),
                  ),
                ),
                child: CatalogItem(catalog: catalog),
              );
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: CatalogModel.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModel.items[index];
              return InkWell(
                onTap: () => context.vxNav.push(
                    Uri(
                        path: MyRoutes.homeDetailsRoute,
                        queryParameters: {'id': catalog.id.toString()}),
                    params: catalog),
                child: CatalogItem(catalog: catalog),
              );
            });
  }
}

class CatalogItem extends StatelessWidget {
  final catalog;

  const CatalogItem({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var children2 = [
      Hero(
              tag: Key(
                catalog.id.toString(),
              ),
              child: CatalogImage(image: catalog.image))
          .p8(), // CatalogImage
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              catalog.name,
              style: TextStyle(
                  fontSize: 17,
                  color: context.theme.accentColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              catalog.desc,
              style: TextStyle(
                  fontSize: 12,
                  color: context.theme.accentColor,
                  fontWeight: FontWeight.w100),
            ),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                Text(
                  '\$${catalog.price}'.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: context.theme.accentColor),
                ),
                AddToCart(
                  catalog: catalog,
                ),
              ],
            ).pOnly(right: 5.0)
          ],
        ).p(context.isMobile ? 0 : 16),
      ),
    ];
    return VxBox(
            child: context.isMobile
                ? Row(
                    children: children2,
                  )
                : Column(
                    children: children2,
                  ))
        .color(context.cardColor)
        .rounded
        .square(150)
        .make()
        .py16();
  }
}
