/// Получаем форму слова исходя из числительного.
///
/// Пример.
/// 1 - исполните(ль). 2 - исполните(ля)
/// В функцию передается список слов для трех вариантов и число.
/// Функция возвращает нужный вариант слова.
/// Пример: [1 - день, 2 - дня, много - дней]
String selectWordFormByNum(List<String> titles, int numeral) {
  final cases = [2, 0, 1, 1, 1, 2];
  return titles[(numeral % 100 > 4 && numeral % 100 < 20)
      ? 2
      : cases[(numeral % 10 < 5) ? numeral % 10 : 5]];
}
