class DeviceModel {
  final String id;
  final String name; // e.g., 'PT02E-99001'
  final String imageUrl; // �豸ͼƬ URL
  final int batteryLevel; // �����ٷֱ� (0-100)
  final String status; // ״̬���� '��Ϣ', '�˶�' ��
  final String networkType; // �������ͣ��� '4G', 'WIFI' ��
  final int signalStrength; // �ź�ǿ�� (0-4)
  final String address; // ��λ��ַ
  final DateTime lastUpdateTime; // ������ʱ��

  DeviceModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.batteryLevel,
    required this.status,
    required this.networkType,
    required this.signalStrength,
    required this.address,
    required this.lastUpdateTime,
  });

  // Ԥ�����˶Խӵ� API �ṹ (fromJson)
  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      batteryLevel: json['batteryLevel'] as int? ?? 0,
      status: json['status'] as String? ?? '����',
      networkType: json['networkType'] as String? ?? 'δ֪',
      signalStrength: json['signalStrength'] as int? ?? 0,
      address: json['address'] as String? ?? '',
      lastUpdateTime: json['lastUpdateTime'] != null
          ? DateTime.parse(json['lastUpdateTime'])
          : DateTime.now(),
    );
  }

  // Ԥ�����л����� (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'batteryLevel': batteryLevel,
      'status': status,
      'networkType': networkType,
      'signalStrength': signalStrength,
      'address': address,
      'lastUpdateTime': lastUpdateTime.toIso8601String(),
    };
  }

  // ǰ�˿����Ͳ���ʹ�õ� Mock ����
  static List<DeviceModel> getMockDevices() {
    return [
      DeviceModel(
        id: 'dev_001',
        name: 'PT02E-99001',
        imageUrl:
            'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=200&auto=format&fit=crop', // �滻Ϊ�ɿ��Ĺ���/�豸ռλͼ
        batteryLevel: 54,
        status: '��Ϣ',
        networkType: '4G',
        signalStrength: 3, // 4���ź���ռ3��
        address: 'ʯ��·�������������ֵ�����ɽ���������У��㶫ʡ��518000...',
        lastUpdateTime: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  }
}
