class ItemException implements Exception {
  const ItemException();
}

abstract class ItemNotFoundException extends ItemException {
  const ItemNotFoundException();
}

class ItemByIdNotFoundException extends ItemException {
  final int id;

  const ItemByIdNotFoundException({
    required this.id,
  });
}
