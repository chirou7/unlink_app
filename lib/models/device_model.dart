class DeviceModel {
  final String id;
  final String name; // e.g., 'PT02E-99001'
  final String imageUrl; // 设备图片 URL
  final int batteryLevel; // 电量百分比 (0-100)
  final String status; // 状态，如 '休息', '运动' 等
  final String networkType; // 网络类型，如 '4G', 'WIFI' 等
  final int signalStrength; // 信号强度 (0-4)
  final String address; // 定位地址
  final DateTime lastUpdateTime; // 最后更新时间

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

  // 预留反序列化 (fromJson)
  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      batteryLevel: json['batteryLevel'] as int? ?? 0,
      status: json['status'] as String? ?? '离线',
      networkType: json['networkType'] as String? ?? '未知',
      signalStrength: json['signalStrength'] as int? ?? 0,
      address: json['address'] as String? ?? '',
      lastUpdateTime: json['lastUpdateTime'] != null
          ? DateTime.parse(json['lastUpdateTime'])
          : DateTime.now(),
    );
  }

  // 预留序列化 (toJson)
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

  // 前端快速测试使用的 Mock 数据
  static List<DeviceModel> getMockDevices() {
    return [
      DeviceModel(
        id: 'dev_001',
        name: 'PT02E-99001',
        imageUrl:
            'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=200&auto=format&fit=crop', // 替换为可用的狗狗/设备占位图
        batteryLevel: 48,
        status: '休息',
        networkType: '4G',
        signalStrength: 3, // 4格信号占3格
        address: '石鼓路, 西丽, 西丽街道, 南山区, 深圳市, 广东省, 518000...',
        lastUpdateTime: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  }
}
