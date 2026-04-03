class PetProfileModel {
  String name;
  String breed;
  String gender;

  // ������ص�״̬
  String birthdayLabel; // ���ڽ���չʾ���İ����� '2023-05-01'
  DateTime? birthdayDate; // �����߼��жϺʹ洢��ʱ�����

  // ����ָ�� (ͳһ�Թ��� kg/cm �洢�� Model ��)
  String weightKg;
  String heightCm;
  String lengthCm;

  // ����״̬
  String neutered;
  String vaccineStatus;
  String vaccineDateLabel; // ���ڽ���չʾ���İ�
  DateTime? vaccineDate; // �����߼��жϵ�ʱ�����

  // ý����Ϣ
  String avatarPath;

  PetProfileModel({
    this.name = '',
    this.breed = '',
    this.gender = '',
    this.birthdayLabel = '',
    this.birthdayDate,
    this.weightKg = '',
    this.heightCm = '',
    this.lengthCm = '',
    this.neutered = '',
    this.vaccineStatus = '',
    this.vaccineDateLabel = '',
    this.vaccineDate,
    this.avatarPath = '',
  });

  /// ��ģ��תΪ JSON������δ���ύ����� API
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'breed': breed,
      'gender': gender,
      'birthday': birthdayDate?.toIso8601String(),
      'weight': double.tryParse(weightKg),
      'height': double.tryParse(heightCm),
      'length': double.tryParse(lengthCm),
      'isNeutered': neutered == '��',
      'isVaccinated': vaccineStatus == '�ѽ���',
      'vaccineDate': vaccineDate?.toIso8601String(),
      'avatarPath': avatarPath,
    };
  }

  /// �Ӻ�˷��ص� JSON ��ʼ��ģ�� (Ԥ��)
  factory PetProfileModel.fromJson(Map<String, dynamic> json) {
    return PetProfileModel(
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
      gender: json['gender'] ?? '',
      birthdayDate: json['birthday'] != null
          ? DateTime.parse(json['birthday'])
          : null,
      weightKg: json['weight']?.toString() ?? '',
      heightCm: json['height']?.toString() ?? '',
      lengthCm: json['length']?.toString() ?? '',
      neutered: json['isNeutered'] == true
          ? '��'
          : (json['isNeutered'] == false ? '��' : ''),
      vaccineStatus: json['isVaccinated'] == true
          ? '�ѽ���'
          : (json['isVaccinated'] == false ? 'δ����' : ''),
      vaccineDate: json['vaccineDate'] != null
          ? DateTime.parse(json['vaccineDate'])
          : null,
      avatarPath: json['avatarPath'] ?? '',
    );
  }
}
