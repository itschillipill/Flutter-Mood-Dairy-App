enum Mood {
  happy("Радость", "happy.png"),
  fear("Страх", "fear.png"),
  anger("Бешенство", "anger.png"),
  sad("Грусть", "sad.png"),
  calm("Спокойствие", "calm.png"),
  strong("Сила", "strong.png");

  final String text;
  final String asset;
  const Mood(this.text, this.asset);
}

List<String> moodState = [
  "Возбуждение",
  "Восторг",
  "Игривость",
  "Наслаждение",
  "Очарование",
  "Осознанность",
  "Смелость",
  "Удовольствие",
  "Чувственность",
  "Энергичность",
  "Экстравагантность"
];
