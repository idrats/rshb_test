class Category {
  static const Category vegetables = Category._(1);
  static const Category bread = Category._(2);
  static const Category eggs = Category._(3);
  static const Category meat = Category._(4);
  static const Category fish = Category._(5);
  static const Category preserves = Category._(6);

  final int _category;

  const Category._(int category) : _category = category;

  factory Category(int category) {
    if (category == null) return null;
    Category _curCategory = Category._(category);
    if (values.contains(_curCategory)) {
      return _curCategory;
    } else {
      throw ArgumentError('Unknown category: $category.');
    }
  }

  final Map<int, String> _categoryStr = const {
    1: 'Овощи и фрукты',
    2: 'Хлеб и выпечка',
    3: 'Молоко и яйца',
    4: 'Мясо',
    5: 'Рыба',
    6: 'Консервы',
  };

  int get value => _category;
  static List get values => [vegetables, bread, eggs, meat, fish, preserves];

  @override
  bool operator ==(dynamic other) {
    if (other is Category) {
      return other._category == _category;
    }
    return false;
  }

  @override
  int get hashCode => _category.hashCode;

  @override
  String toString() => _categoryStr[_category];
}
