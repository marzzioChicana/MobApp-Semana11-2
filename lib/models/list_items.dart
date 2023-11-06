class ListItems {
  int id;
  int idList;
  String name;
  int quantity;
  String note;

  ListItems(this.id, this.idList, this.name, this.quantity, this.note);

  // Vamos a crear el metodo toMap, para hacer el mapeo de la clase a la tabla
  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0)? null : id,
      'idList': idList,
      'name': name,
      'quantity': quantity,
      'note': note
    };
  }
}