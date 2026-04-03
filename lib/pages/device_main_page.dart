import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/device_model.dart';
import 'device_detail_page.dart';
import 'find_pet_page.dart';
import 'health_page.dart';
import 'pet_detail_page.dart';

class DeviceMainPage extends StatefulWidget {
  final DeviceModel device;
  final int initialIndex;

  const DeviceMainPage({
    super.key,
    required this.device,
    this.initialIndex = 0,
  });

  @override
  State<DeviceMainPage> createState() => _DeviceMainPageState();
}

class _DeviceMainPageState extends State<DeviceMainPage> {
  late int _currentIndex;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    // ʹ�� IndexedStack ���ָ�ҳ��״̬
    _pages = [
      DeviceDetailPage(device: widget.device),
      FindPetPage(device: widget.device),
      HealthPage(device: widget.device),
      // ��ʱֱ��ʹ�� PetDetailPage���������ʵҵ����Ը����豸�Ƿ��г���ѡ����� PetEmptyPage
      PetDetailPage(device: widget.device),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      // ͳһ�����ĵײ�������
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            HapticFeedback.selectionClick();
            setState(() => _currentIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF111111),
          unselectedItemColor: const Color(0xFFAAAAAA),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.location_on_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.location_on),
              ),
              label: '��ҳ',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.surround_sound_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.surround_sound),
              ),
              label: 'Ѱ��',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.monitor_heart_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.monitor_heart),
              ),
              label: '����',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.pets_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.pets),
              ),
              label: '����',
            ),
          ],
        ),
      ),
    );
  }
}
