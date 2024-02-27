import 'package:swipetivity_app/exception/item_exceptions.dart';
import 'package:swipetivity_app/model/item.dart';

class ItemRepository {
  final List<Item> items = const [
    Item(
      id: 1,
      name: 'Item 1',
      description: 'Description for Item 1',
    ),
    Item(
      id: 2,
      name: 'Item 2',
      description: 'Description for Item 2',
    ),
    Item(
      id: 3,
      name: 'Item 3',
      description: 'Description for Item 3',
    ),
  ];

  Future<List<Item>> fetchItems() async {
    return Future.delayed(const Duration(seconds: 1), () => items);
  }

  Future<Item> fetchItem(int id) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return items.firstWhere((item) {
        return item.id == id;
      }, orElse: () {
        throw ItemByIdNotFoundException(id: id);
      });
    });
  }
}
