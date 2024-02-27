import 'package:who_boogles_it/core/util/nickname_generator.dart';

class NicknameGeneratorMock extends NicknameGenerator {
  reloadTranslationsByLang(String lang) {
    if (lang == 'en') {
      what = [
        'Angry',
        'Quiet',
        'Sad',
        'Sleepy',
        'Confused',
        'Strange',
        'Rare',
        'Lucky',
        'Ugly',
        'Careful',
        'Lazy',
        'Boring',
        'Brave',
        'Busy',
        'Antic',
        'Young',
        'Crispy',
        'Wild',
        'Old',
        'Fuzzy'
      ];
      who = [
        'Banana',
        'Bat',
        'Worm',
        'Snake',
        'Fish',
        'Viper',
        'Rat',
        'Lion',
        'Hawk',
        'Octopus',
        'Frog',
        'Ant',
        'Jaguar',
        'Donut',
        'Mouse',
        'Duck',
        'Elf',
        'Gorilla',
        'Horse'
      ];
    } else if (lang == 'ru') {
      what = [
        'Злой',
        'Помятый',
        'Грустный',
        'Сонный',
        'Странный',
        'Редкий',
        'Честный',
        'Дикий',
        'Ленивый',
        'Скучный',
        'Храбрый',
        'Занятой',
        'Одинокий',
        'Молодой',
        'Хитрый',
        'Пушистый',
        'Старый'
      ];
      who = [
        'Банан',
        'Заяц',
        'Помидор',
        'Крот',
        'Змей',
        'Медведь',
        'Спрут',
        'Крыс',
        'Червяк',
        'Ястреб',
        'Осьминог',
        'Лев',
        'Муравей',
        'Ягуар',
        'Пончик',
        'Лось',
        'Кабан',
        'Эльф',
        'Олень',
        'Конь',
        'Еж'
      ];
    } else {
      throw 'Unsupported language: $lang';
    }
  }
}
