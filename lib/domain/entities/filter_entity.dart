enum FilterType { category, price, rating }

class FilterEntity {
  final String id;
  final String name;
  final FilterType type;
  final String? value;

  const FilterEntity({
    required this.id,
    required this.name,
    required this.type,
    this.value,
  });
}
