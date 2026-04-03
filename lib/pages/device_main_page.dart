import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/device_model.dart';
import '../l10n/app_localizations.dart';
import 'device_detail_page.dart';
import 'find_pet_page.dart';
import 'health_page.dart';
import 'pet_empty_page.dart';

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

  List<Widget> get _pages => [
    DeviceDetailPage(device: widget.device),
    FindPetPage(device: widget.device),
    HealthPage(device: widget.device),
    const PetEmptyPage(hasPet: false), // 根据上下文，添加设备跳过后这里默认应为无宠物状态
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
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
          items: [
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.location_on_outlined),
              ),
              activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.location_on),
              ),
              label: AppLocalizations.of(context)!.homeTab,
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.surround_sound_outlined),
              ),
              activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.surround_sound),
              ),
              label: AppLocalizations.of(context)!.findPet,
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.monitor_heart_outlined),
              ),
              activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.monitor_heart),
              ),
              label: AppLocalizations.of(context)!.healthTab,
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.pets_outlined),
              ),
              activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.pets),
              ),
              label: AppLocalizations.of(context)!.petTab,
            ),
          ],
        ),
      ),
    );
  }
}
