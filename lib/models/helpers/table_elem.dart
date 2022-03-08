class TableElem {
  dynamic _columnName;
  dynamic _value;

  TableElem({required dynamic columnName, required dynamic value})
      : _columnName = columnName,
        _value = value;

  String get value => _value.toString();
  String get columnName => _columnName.toString();
}
