abstract class ItemCategoryException implements Exception {
  const ItemCategoryException();
}

abstract class ItemCategoryNotFoundException extends ItemCategoryException {
  const ItemCategoryNotFoundException();
}

class ItemCategoryByIdNotFoundException extends ItemCategoryException {
  final int id;

  const ItemCategoryByIdNotFoundException({
    required this.id,
  });
}