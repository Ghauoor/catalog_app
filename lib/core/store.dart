import 'package:velocity_x/velocity_x.dart';

import '../models/catalog.dart';
import '../models/cart.dart';

class MyStore extends VxStore {
  late CatalogModel catalog;
  late CartModel cart;

  MyStore() {
    catalog = CatalogModel();
    cart = CartModel();
    cart.catalog = catalog;
  }
}
