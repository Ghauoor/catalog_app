import 'package:flutter_catalog/core/store.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  //Singleton pattern
  /*
  static final cartModel = CartModel._internal();
  CartModel._internal();
  factory CartModel() => cartModel;
  */
  //catalog field
  late CatalogModel _catalog;

  //Collection of ids - store ids of each items
  final List<int> _itemIds = [];

  //get catalog
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  //Get items in the cart

  List<Item> get items => _itemIds
      .map(
        (id) => _catalog.getById(id),
      )
      .toList();

  //Get Total price

  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //Add Items
  //Due to Mutation
  // void add(Item item) => _itemIds.add(item.id);

  //remove item
 // void remove(Item item) => _itemIds.remove(item.id);
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(this.item);

  @override
  perform() {
    store!.cart._itemIds.add(item.id);
  }
}
class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(this.item);

  @override
  perform() {
    store!.cart._itemIds.remove(item.id);
  }
}

