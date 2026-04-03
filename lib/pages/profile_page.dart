import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../widgets/default_avatar.dart';
import '../widgets/common_list_tile.dart';
import 'settings_page.dart';
import 'help_feedback_page.dart';
import 'about_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 顶部用户信息区域 (带渐变背景)
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFFFBE6), // 极浅的黄色
                          Color(0xFFF3FAEE), // 极浅的绿色
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 80, // 适配刘海屏
                      bottom: 32,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '李杰', // TODO: 替换为真实用户名
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '1113538716@qq.com', // TODO: 替换为真实邮箱
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 头像及编辑图标
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const DefaultAvatarWidget(size: 72),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.textPrimary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 订单与设备卡片
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        // 订单卡片
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            title: l10n.orders,
                            iconColor: const Color(0xFFFFF0D4),
                            iconData: Icons.receipt_long,
                            iconInnerColor: const Color(0xFFF5A623),
                            subtitle: l10n.inUse(0, 0),
                            onTap: () {
                              // TODO: 跳转到订单页面
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // 设备卡片
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            title: l10n.devices,
                            iconColor: const Color(0xFFE2F6EB),
                            iconData: Icons.dns, // 类似设备的图标
                            iconInnerColor: const Color(0xFF34C759),
                            subtitle: l10n.activated(0, 0),
                            onTap: () {
                              // 返回首页即设备列表
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 设置菜单列表
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        children: [
                          CommonListTile(
                            title: l10n.settings,
                            leading: const Icon(
                              Icons.settings_outlined,
                              color: AppColors.textSecondary,
                              size: 22,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsPage(),
                                ),
                              );
                            },
                          ),
                          CommonListTile(
                            title: l10n.helpAndFeedback,
                            leading: const Icon(
                              Icons.help_outline,
                              color: AppColors.textSecondary,
                              size: 22,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const HelpFeedbackPage(),
                                ),
                              );
                            },
                          ),
                          CommonListTile(
                            title: l10n.about,
                            leading: const Icon(
                              Icons.info_outline,
                              color: AppColors.textSecondary,
                              size: 22,
                            ),
                            hasBorderBottom: false,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AboutPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // 底部导航栏
          Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.home_outlined, // 首页未选中状态
                      color: Color(0xFFAAAAAA),
                      size: 28,
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      // 返回首页
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person, // 个人中心选中状态
                      color: Color(0xFFF5C518),
                      size: 28,
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      // 已在当前页，不处理
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required Color iconColor,
    required IconData iconData,
    required Color iconInnerColor,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: iconInnerColor, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  subtitle.split(' ')[0], // 数字部分如 "0"
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  subtitle
                      .substring(subtitle.indexOf(' '))
                      .trim(), // 文字部分如 "/ 0 使用中"
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
