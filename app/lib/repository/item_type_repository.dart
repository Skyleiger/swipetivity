import 'package:swipetivity_app/exception/item_type_exceptions.dart';
import 'package:swipetivity_app/model/item_type.dart';

class ItemTypeRepository {
  final List<ItemType> itemTypes = const [
    ItemType(
      id: 1,
      name: "Test Item Type",
      description: "Test Description",
    ),
    ItemType(
      id: 2,
      name: "Test Item Type 2",
      description: "Test Description 2",
    ),
    ItemType(
      id: 3,
      name: "Test Item Type 3",
    ),
    ItemType(
      id: 4,
      name: "Test Item Type 4",
      description: "Test Description 4",
    ),
  ];

  Future<List<ItemType>> fetchItemTypes() {
    return Future.delayed(const Duration(seconds: 1), () => itemTypes);
  }

  Future<ItemType> fetchItemType(int id) {
    return Future.delayed(const Duration(seconds: 1), () {
      return itemTypes.firstWhere((itemType) {
        return itemType.id == id;
      }, orElse: () {
        throw ItemTypeByIdNotFoundException(id: id);
      });
    });
  }
}
