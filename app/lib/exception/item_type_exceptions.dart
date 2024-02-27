class ItemTypeException implements Exception {
  const ItemTypeException();
}

abstract class ItemTypeNotFoundException extends ItemTypeException {
  const ItemTypeNotFoundException();
}

class ItemTypeByIdNotFoundException extends ItemTypeException {
  final int id;

  const ItemTypeByIdNotFoundException({
    required this.id,
  });
}
