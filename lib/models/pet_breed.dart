import 'package:lpinyin/lpinyin.dart';

class PetBreed {
  final String name;
  final String alias;
  final bool isHot;
  late final String pinyin;
  late final String firstLetter;

  PetBreed({
    required this.name,
    this.alias = '',
    this.isHot = false,
  }) {
    // Generate pinyin from name (without spaces)
    pinyin = PinyinHelper.getPinyinE(name, defPinyin: '#', format: PinyinFormat.WITHOUT_TONE).replaceAll(' ', '').toLowerCase();
    
    // Generate first letter (A-Z or #)
    if (pinyin.isNotEmpty && pinyin != '#') {
      String firstChar = pinyin[0].toUpperCase();
      if (RegExp(r'[A-Z]').hasMatch(firstChar)) {
        firstLetter = firstChar;
      } else {
        firstLetter = '#';
      }
    } else {
      firstLetter = '#';
    }
  }

  String get displayName => alias.isNotEmpty ? '$name ($alias)' : name;

  static List<PetBreed> mockDogs() {
    return [
      PetBreed(name: '金毛寻回犬', alias: '金毛', isHot: true),
      PetBreed(name: '拉布拉多寻回犬', alias: '拉布拉多', isHot: true),
      PetBreed(name: '法国斗牛犬', alias: '法斗', isHot: true),
      PetBreed(name: '贵宾犬', alias: '泰迪'),
      PetBreed(name: '威尔士柯基犬', alias: '柯基'),
      PetBreed(name: '柴犬'),
      PetBreed(name: '比熊犬', alias: '比熊'),
      PetBreed(name: '边境牧羊犬', alias: '边牧'),
      PetBreed(name: '博美犬', alias: '博美'),
      PetBreed(name: '中华田园犬', alias: '土狗'),
      PetBreed(name: '德国牧羊犬', alias: '德牧'),
      PetBreed(name: '雪纳瑞'),
      PetBreed(name: '混血/串串狗'),
      PetBreed(name: '不确定/未知品种'),
    ];
  }

  static List<PetBreed> mockCats() {
    return [
      PetBreed(name: '英国短毛猫', alias: '英短', isHot: true),
      PetBreed(name: '布偶猫', isHot: true),
      PetBreed(name: '缅因猫', isHot: true),
      PetBreed(name: '美国短毛猫', alias: '美短'),
      PetBreed(name: '加菲猫', alias: '异国短毛猫'),
      PetBreed(name: '暹罗猫'),
      PetBreed(name: '苏格兰折耳猫', alias: '折耳猫'),
      PetBreed(name: '中华田园猫', alias: '土猫'),
      PetBreed(name: '孟加拉豹猫', alias: '豹猫'),
      PetBreed(name: '波斯猫'),
      PetBreed(name: '混血/串串猫'),
      PetBreed(name: '不确定/未知品种'),
    ];
  }
}
