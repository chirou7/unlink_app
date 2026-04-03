class UnitConverter {
  // ��ǰȫ��ʹ�õĵ�λϵͳ��
  // true ��ʾ���� (Metric): kg, cm
  // false ��ʾӢ�� (Imperial): lbs, inch
  // ������ʱӲ����Ϊ true (����)��δ������ͨ�� SharedPreferences ��״̬������̬�ı�����
  static bool useMetric = true;

  // -------------------------
  // ��λ�İ���ȡ
  // -------------------------

  /// ��ȡ��ǰϵͳ��������λ�İ�
  static String get weightUnitLabel => useMetric ? 'kg' : 'lbs';

  /// ��ȡ��ǰϵͳ�ĳ��ȵ�λ�İ�
  static String get lengthUnitLabel => useMetric ? 'cm' : 'inch';

  // -------------------------
  // �����뻻�����
  // -------------------------
  static const double _kgToLbsRatio = 2.20462;
  static const double _cmToInchRatio = 0.393701;

  // -------------------------
  // ��ֵ���� (��ʾ���û�)
  // �����ݿ��д洢���ǻ�׼�Ĺ��Ƶ�λʱ�����ݵ�ǰ���þ����Ƿ�ת��ΪӢ����ʾ
  // -------------------------

  /// �����ݿ��е�����(kg)ת��Ϊ��ǰϵͳ��λ������ʾ
  static String formatWeightForDisplay(String baseWeightKg) {
    if (baseWeightKg.isEmpty) return '';
    final numValue = double.tryParse(baseWeightKg);
    if (numValue == null) return baseWeightKg;

    if (useMetric) {
      return baseWeightKg; // �Ѿ��� kg��ֱ�ӷ���
    } else {
      // תΪ lbs������һλС��
      return (numValue * _kgToLbsRatio).toStringAsFixed(1);
    }
  }

  /// �����ݿ��еĳ���(cm)ת��Ϊ��ǰϵͳ��λ������ʾ
  static String formatLengthForDisplay(String baseLengthCm) {
    if (baseLengthCm.isEmpty) return '';
    final numValue = double.tryParse(baseLengthCm);
    if (numValue == null) return baseLengthCm;

    if (useMetric) {
      return baseLengthCm; // �Ѿ��� cm��ֱ�ӷ���
    } else {
      // תΪ inch������һλС��
      return (numValue * _cmToInchRatio).toStringAsFixed(1);
    }
  }

  // -------------------------
  // ��ֵ���� (���浽���ݿ�)
  // �����û��ڽ������������ kg ���� lbs��ͳһת��Ϊ��׼�Ĺ��Ƶ�λ (kg/cm) ����
  // -------------------------

  /// ���û��ڽ����������������ͳһת��Ϊ kg ����
  static String parseWeightToBase(String inputWeight) {
    if (inputWeight.isEmpty) return '';
    final numValue = double.tryParse(inputWeight);
    if (numValue == null) return inputWeight;

    if (useMetric) {
      return inputWeight;
    } else {
      // ������� lbs��ת�� kg ����
      return (numValue / _kgToLbsRatio).toStringAsFixed(2);
    }
  }

  /// ���û��ڽ���������ĳ��ȣ�ͳһת��Ϊ cm ����
  static String parseLengthToBase(String inputLength) {
    if (inputLength.isEmpty) return '';
    final numValue = double.tryParse(inputLength);
    if (numValue == null) return inputLength;

    if (useMetric) {
      return inputLength;
    } else {
      // ������� inch��ת�� cm ����
      return (numValue / _cmToInchRatio).toStringAsFixed(2);
    }
  }

  // -------------------------
  // ����������ʾ (���� C������������ʱ�ṩ��һ�ֵ�λ��ʵʱ�ο�)
  // -------------------------

  /// �����û��ڵ�ǰϵͳ��λ���������ֵ��������һ�ֵ�λ�Ļ����ַ������磺���� 10(kg)������ "Լ���� 22.0 lbs"��
  static String getConversionHint(String inputValue, {required bool isWeight}) {
    if (inputValue.isEmpty) return '';
    final numValue = double.tryParse(inputValue);
    if (numValue == null || numValue <= 0) return '';

    if (isWeight) {
      if (useMetric) {
        // ��ǰ�� kg������ lbs
        return 'Լ���� ${(numValue * _kgToLbsRatio).toStringAsFixed(1)} lbs';
      } else {
        // ��ǰ�� lbs������ kg
        return 'Լ���� ${(numValue / _kgToLbsRatio).toStringAsFixed(1)} kg';
      }
    } else {
      if (useMetric) {
        // ��ǰ�� cm������ inch
        return 'Լ���� ${(numValue * _cmToInchRatio).toStringAsFixed(1)} inch';
      } else {
        // ��ǰ�� inch������ cm
        return 'Լ���� ${(numValue / _cmToInchRatio).toStringAsFixed(1)} cm';
      }
    }
  }

  // -------------------------
  // У��߽�ֵ��ȡ (���ݵ�ǰ��λ��̬����)
  // -------------------------

  /// ��ȡ������������������ֵ
  static double get maxWeightLimit =>
      useMetric ? 200.0 : 440.0; // 200kg Լ���� 440lbs

  /// ��ȡ������������������ֵ
  static double get maxLengthLimit =>
      useMetric ? 300.0 : 118.0; // 300cm Լ���� 118inch
}
