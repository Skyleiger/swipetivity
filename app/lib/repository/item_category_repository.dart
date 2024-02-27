import 'package:swipetivity_app/exception/item_category_exceptions.dart';
import 'package:swipetivity_app/model/item_category.dart';

class ItemCategoryRepository {
  final List<ItemCategory> itemCategories = const [
    ItemCategory(
      id: 1,
      name: "Test Item Category",
      description: "Test Description",
    ),
    ItemCategory(
      id: 2,
      name: "Test Item Category 2",
      description: "Test Description 2",
    ),
    ItemCategory(
      id: 3,
      name: "Test Item Category 3",
      description: "Test Description 3",
    ),
    ItemCategory(
      id: 4,
      name: "Test Item Category 4",
    ),
  ];

  Future<List<ItemCategory>> fetchItemCategories() async {
    return Future.delayed(const Duration(seconds: 1), () => itemCategories);
  }

  Future<ItemCategory> fetchItemCategory(int id) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return itemCategories.firstWhere((itemCategory) {
        return itemCategory.id == id;
      }, orElse: () {
        throw ItemCategoryByIdNotFoundException(id: id);
      });
    });
  }
}