class Supplier {
  int id;
  String name;

  Supplier({required this.id, required this.name});

  @override
  String toString() {
    return name.toString();
  }
}
