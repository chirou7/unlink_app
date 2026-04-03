import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../widgets/common_app_bar.dart';
import '../models/pet_profile_model.dart';
import 'pet_profile_page.dart';

class PetEmptyPage extends StatefulWidget {
  final bool hasPet;

  const PetEmptyPage({super.key, this.hasPet = false});

  @override
  State<PetEmptyPage> createState() => _PetEmptyPageState();
}

class _PetEmptyPageState extends State<PetEmptyPage> {
  // 模拟从本地或服务器获取的宠物列表数据
  late List<PetProfileModel> _pets;
  // 记录当前选中的宠物索引，改为可空（null表示未选中任何宠物）
  int? _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.hasPet) {
      _pets = [
        PetProfileModel(
          name: 'lo',
          breed: '中华田园犬',
          gender: '雄性',
          birthdayDate: DateTime.now().subtract(
            const Duration(days: 60),
          ), // 模拟2个月大
        ),
      ];
    } else {
      _pets = [];
    }
  }

  // 根据生日计算年龄（例如：2月、1岁、1岁2月）
  String _calculateAge(DateTime? birthday, AppLocalizations l10n) {
    if (birthday == null) return '';
    final now = DateTime.now();
    int years = now.year - birthday.year;
    int months = now.month - birthday.month;

    if (now.day < birthday.day) {
      months--;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    if (years > 0 && months > 0) {
      return l10n.ageYearsMonths(years, months);
    } else if (years > 0) {
      return l10n.ageYears(years);
    } else if (months > 0) {
      return l10n.ageMonths(months);
    } else {
      // 不足一个月算作 1 个月，或者你可以返回特定的如 "不足1月"
      return l10n.ageMonths(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CommonAppBar(title: l10n.petInfo),
      body: _pets.isEmpty
          ? _buildEmptyState(context, l10n)
          : _buildPetListState(context, l10n),
    );
  }

  // ==== 原来的空状态 UI ====
  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmptyIcon(),
            const SizedBox(height: 24),
            Text(
              l10n.noDeviceYet,
              style: const TextStyle(fontSize: 15, color: AppColors.textHint),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  HapticFeedback.selectionClick();
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const PetProfilePage(isFromDeviceMain: true),
                    ),
                  );

                  // 如果从添加页面成功返回了宠物数据，则更新状态
                  if (result != null && result is PetProfileModel) {
                    setState(() {
                      _pets.add(result);
                      _selectedIndex = _pets.length - 1; // 默认选中刚添加的宠物
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.addDevice,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==== 新增的列表状态 UI ====
  Widget _buildPetListState(BuildContext context, AppLocalizations l10n) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), // 底部留出按钮空间
          children: [
            // 已添加的宠物列表
            ...List.generate(_pets.length, (index) {
              final pet = _pets[index];
              final isSelected = _selectedIndex == index;
              return _buildPetCard(pet, isSelected, index, l10n);
            }),
            // 继续添加宠物的卡片
            _buildAddPetCard(context, l10n),
          ],
        ),
        // 底部固定的“选择”按钮
        Positioned(
          left: 16,
          right: 16,
          bottom: 32, // SafeArea 可以在 Scaffold body 也可以直接在此控制
          child: SafeArea(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedIndex != null
                    ? () {
                        HapticFeedback.selectionClick();
                        // TODO: 处理选择宠物的逻辑，如绑定设备、更新状态等
                      }
                    : null, // 如果未选中任何宠物，禁用按钮
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  disabledBackgroundColor: AppColors.primaryYellowLight
                      .withValues(alpha: 0.5), // 禁用状态的颜色
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.selectAction, // 多语言：选择
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedIndex != null
                        ? AppColors.textPrimary
                        : AppColors.textHint, // 禁用时的文字颜色
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPetCard(
    PetProfileModel pet,
    bool isSelected,
    int index,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() {
          // 如果当前已经选中了该卡片，再次点击则取消选中
          if (_selectedIndex == index) {
            _selectedIndex = null;
          } else {
            _selectedIndex = index;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: AppColors.primaryYellow, width: 1.5)
              : Border.all(color: Colors.transparent, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 头像占位，截图里是一个灰色带小狗头和绿色链接图标的样式
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.pets, color: Color(0xFFD4D4D4), size: 32),
                  ),
                ),
                // 绿色的 link 图标角标
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.successGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.link,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // 宠物信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      // 性别 + 品种 标签
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F8FA),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              pet.gender == l10n.male || pet.gender == '雄性'
                                  ? Icons.male
                                  : Icons.female,
                              size: 14,
                              color:
                                  pet.gender == l10n.male || pet.gender == '雄性'
                                  ? const Color(0xFF5E9CFF) // 蓝色表示雄性
                                  : const Color(0xFFFF6B8A), // 粉色表示雌性
                            ),
                            const SizedBox(width: 4),
                            Text(
                              pet.breed,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 年龄 标签
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF9E6), // 浅黄底色
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.cake_outlined,
                              size: 14,
                              color: AppColors.primaryYellow,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _calculateAge(pet.birthdayDate, l10n),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 选中状态的打勾图标
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.primaryYellow,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.textPrimary,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPetCard(BuildContext context, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.selectionClick();
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PetProfilePage(isFromDeviceMain: true),
          ),
        );

        // 如果从添加页面成功返回了宠物数据，则更新状态
        if (result != null && result is PetProfileModel) {
          setState(() {
            _pets.add(result);
            _selectedIndex = _pets.length - 1; // 默认选中刚添加的宠物
          });
        }
      },
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dividerLight),
              ),
              child: const Icon(Icons.add, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 16),
            Text(
              l10n.addPet,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }

  // （原样保留的 _buildEmptyIcon 及 CustomPainter 代码省略展示，不改变）
  Widget _buildEmptyIcon() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: -16,
          child: Container(
            width: 80,
            height: 12,
            decoration: const BoxDecoration(
              color: Color(0xFFE2E8F0),
              borderRadius: BorderRadius.all(Radius.elliptical(40, 6)),
            ),
          ),
        ),
        Positioned(
          left: -20,
          top: 10,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primaryYellow.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -8,
          top: 40,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: AppColors.primaryYellow.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: -16,
          top: 20,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.primaryYellow.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: -16,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.primaryYellow.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -24,
          left: 10,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: AppColors.primaryYellow.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          width: 110,
          height: 110,
          decoration: const BoxDecoration(
            color: AppColors.primaryYellow,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: CustomPaint(
            size: const Size(56, 56),
            painter: DogSilhouettePainter(),
          ),
        ),
      ],
    );
  }
}

class DogSilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final bodyPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final bodyPath = Path();
    bodyPath.moveTo(w * 0.1, h * 0.9);
    bodyPath.quadraticBezierTo(w * 0.1, h * 0.4, w * 0.3, h * 0.2);
    bodyPath.quadraticBezierTo(w * 0.5, h * 0.05, w * 0.7, h * 0.2);
    bodyPath.lineTo(w * 0.95, h * 0.35);
    bodyPath.quadraticBezierTo(w * 1.0, h * 0.45, w * 0.85, h * 0.5);
    bodyPath.quadraticBezierTo(w * 0.75, h * 0.5, w * 0.7, h * 0.6);
    bodyPath.quadraticBezierTo(w * 0.65, h * 0.8, w * 0.9, h * 0.9);
    bodyPath.lineTo(w * 0.1, h * 0.9);
    bodyPath.close();

    canvas.drawPath(bodyPath, bodyPaint);

    final earPaint = Paint()..style = PaintingStyle.fill;

    final earColor = const Color(0xFFF1C84B);
    earPaint.color = earColor;

    final earPath = Path();
    earPath.moveTo(w * 0.35, h * 0.25);
    earPath.quadraticBezierTo(w * 0.2, h * 0.4, w * 0.25, h * 0.65);
    earPath.quadraticBezierTo(w * 0.3, h * 0.75, w * 0.4, h * 0.65);
    earPath.quadraticBezierTo(w * 0.45, h * 0.4, w * 0.45, h * 0.3);
    earPath.close();

    canvas.drawPath(earPath, earPaint);

    final eyePaint = Paint()
      ..color = AppColors.primaryYellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.65, h * 0.35), 4, eyePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
