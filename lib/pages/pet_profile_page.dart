import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_date_picker.dart';
import '../models/pet_profile_model.dart';
import 'pet_breed_selection_page.dart';
import 'activation_success_page.dart';

class PetProfilePage extends StatefulWidget {
  final bool isFromDeviceMain; // 标记是否是从设备详情页进来的

  const PetProfilePage({super.key, this.isFromDeviceMain = false});

  @override
  State<PetProfilePage> createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;
  File? _avatarImage;

  // Form State
  String? _petName;
  String? _petBreed;
  String? _petGender;
  DateTime? _petBirthday;
  String? _petWeight;
  String? _petHeight;
  String? _petLength;
  String? _petNeutered;
  String? _petVaccinationStatus;
  DateTime? _petVaccinationDate;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    HapticFeedback.selectionClick();
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _avatarImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CommonAppBar(
        title: '',
        backgroundColor: AppColors.backgroundLight,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Avatar
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: ScaleTransition(
                    scale: _breathingAnimation,
                    child: Stack(
                      children: [
                        // Avatar background with dashed-like or solid border
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFDDDDDD),
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: _avatarImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    _avatarImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.pets,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        // Camera icon badge
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.backgroundWhite,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: AppColors.backgroundWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Group 1: Name
            _buildFormGroup([
              _buildFormItem(
                label: l10n.petName,
                isRequired: true,
                hint: l10n.enterHint,
                value: _petName,
                onTap: () {
                  _showInputBottomSheet(
                    title: l10n.petName,
                    currentValue: _petName,
                    hintText: l10n.pleaseEnter,
                    onSave: (value) => setState(() => _petName = value),
                  );
                },
                showBorder: false,
              ),
            ]),

            // Group 2: Breed, Gender
            _buildFormGroup([
              _buildFormItem(
                label: l10n.petBreed,
                isRequired: true,
                hint: l10n.selectHint,
                value: _petBreed,
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PetBreedSelectionPage(currentSelectedName: _petBreed),
                    ),
                  );
                  if (result != null && result is String) {
                    setState(() => _petBreed = result);
                  }
                },
              ),
              _buildFormItem(
                label: l10n.petGender,
                isRequired: true,
                hint: l10n.selectHint,
                value: _petGender,
                onTap: () {
                  _showSelectionBottomSheet(
                    title: l10n.petGender,
                    options: [l10n.male, l10n.female],
                    currentValue: _petGender,
                    onSelect: (value) => setState(() => _petGender = value),
                  );
                },
                showBorder: false,
              ),
            ]),

            // Group 3: Birthday, Weight, Height, Length
            _buildFormGroup([
              _buildFormItem(
                label: l10n.petBirthday,
                isRequired: true,
                hint: l10n.selectHint,
                value: _petBirthday != null
                    ? DateFormat('yyyy-MM-dd').format(_petBirthday!)
                    : null,
                onTap: () {
                  _showDatePickerBottomSheet(
                    title: l10n.selectHint,
                    currentDate: _petBirthday,
                    onSave: (date) => setState(() => _petBirthday = date),
                  );
                },
              ),
              _buildFormItem(
                label: l10n.petWeight,
                isRequired: true,
                hint: l10n.enterHint,
                value: _petWeight != null ? '$_petWeight kg' : null,
                onTap: () {
                  _showInputBottomSheet(
                    title: l10n.petWeight,
                    currentValue: _petWeight,
                    hintText: l10n.pleaseEnter,
                    unit: 'kg',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onSave: (value) => setState(() => _petWeight = value),
                  );
                },
              ),
              _buildFormItem(
                label: l10n.petHeight,
                isRequired: true,
                hint: l10n.enterHint,
                value: _petHeight != null ? '$_petHeight cm' : null,
                onTap: () {
                  _showInputBottomSheet(
                    title: l10n.petHeight,
                    currentValue: _petHeight,
                    hintText: l10n.pleaseEnter,
                    unit: 'cm',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onSave: (value) => setState(() => _petHeight = value),
                  );
                },
              ),
              _buildFormItem(
                label: l10n.petLength,
                isRequired: true,
                hint: l10n.enterHint,
                value: _petLength != null ? '$_petLength cm' : null,
                onTap: () {
                  _showInputBottomSheet(
                    title: l10n.petLength,
                    currentValue: _petLength,
                    hintText: l10n.pleaseEnter,
                    unit: 'cm',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onSave: (value) => setState(() => _petLength = value),
                  );
                },
                showBorder: false,
              ),
            ]),

            // Group 4: Neutered, Vaccination
            _buildFormGroup([
              _buildFormItem(
                label: l10n.petNeutered,
                isRequired: false,
                hint: l10n.selectHint,
                value: _petNeutered,
                onTap: () {
                  _showSelectionBottomSheet(
                    title: l10n.petNeutered,
                    options: [l10n.yes, l10n.no],
                    currentValue: _petNeutered,
                    onSelect: (value) => setState(() => _petNeutered = value),
                  );
                },
              ),
              _buildFormItem(
                label: l10n.petVaccination,
                isRequired: false,
                hint: l10n.selectHint,
                value: () {
                  if (_petVaccinationStatus == l10n.vacVaccinated) {
                    if (_petVaccinationDate != null) {
                      return '${DateFormat('yyyy${l10n.yearSuffix}M${l10n.monthSuffix}d${l10n.daySuffix}').format(_petVaccinationDate!)}${l10n.vacVaccinated}';
                    }
                    return l10n.vacVaccinated;
                  }
                  return _petVaccinationStatus;
                }(),
                onTap: () {
                  _showSelectionBottomSheet(
                    title: l10n.petVaccination,
                    options: [l10n.vacVaccinated, l10n.vacNotVaccinated],
                    currentValue: _petVaccinationStatus,
                    onSelect: (value) {
                      if (value == l10n.vacVaccinated) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (mounted) {
                            _showVaccinationDatePickerBottomSheet();
                          }
                        });
                      } else {
                        setState(() {
                          _petVaccinationStatus = value;
                          _petVaccinationDate = null;
                        });
                      }
                    },
                  );
                },
                showBorder: false,
              ),
            ]),

            const SizedBox(height: 24),

            // Confirm Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.selectionClick();

                  if (widget.isFromDeviceMain) {
                    // 如果是从设备面板进来的，直接返回构建好的 PetProfileModel
                    final newPet = PetProfileModel(
                      name: _petName ?? '未知宠物',
                      breed: _petBreed ?? '未知品种',
                      gender: _petGender ?? '雄性',
                      birthdayDate: _petBirthday ?? DateTime.now(),
                      weightKg: _petWeight ?? '0',
                      heightCm: _petHeight ?? '0',
                      lengthCm: _petLength ?? '0',
                    );
                    Navigator.pop(context, newPet);
                  } else {
                    // 否则继续走注册流程
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ActivationSuccessPage(userName: '李'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.confirm,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),

            // Skip Button
            if (!widget.isFromDeviceMain)
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 32),
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    // TODO: Skip and navigate
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ActivationSuccessPage(userName: '李'),
                      ),
                    );
                  },
                  child: Text(
                    l10n.skip,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ),
            if (widget.isFromDeviceMain) const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showInputBottomSheet({
    required String title,
    required String? currentValue,
    required String hintText,
    String? unit,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onSave,
  }) {
    final TextEditingController controller = TextEditingController(
      text: currentValue,
    );
    final l10n = AppLocalizations.of(context)!;
    // We use a ValueNotifier to update the border color based on focus
    final ValueNotifier<bool> isFocused = ValueNotifier(true);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.dividerLighter,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.textPrimary,
                          size: 24,
                        ),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          onSave(controller.text.trim());
                          Navigator.pop(context);
                        },
                        child: Text(
                          l10n.save,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.infoBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Input Field
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isFocused,
                    builder: (context, focused, child) {
                      return Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: focused
                                ? AppColors.primaryYellow
                                : AppColors.dividerLight,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Focus(
                                onFocusChange: (hasFocus) {
                                  isFocused.value = hasFocus;
                                },
                                child: TextField(
                                  controller: controller,
                                  keyboardType: keyboardType,
                                  autofocus: true,
                                  cursorColor: AppColors.primaryYellow,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: hintText,
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textHint,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (unit != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Text(
                                  unit,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSelectionBottomSheet({
    required String title,
    required List<String> options,
    required String? currentValue,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                height: 60,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              // List
              ...options.map((option) {
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onSelect(option);
                    Navigator.pop(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColors.dividerLighter,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SafeArea(child: SizedBox(height: 16)),
            ],
          ),
        );
      },
    );
  }

  void _showDatePickerBottomSheet({
    required String title,
    required DateTime? currentDate,
    required Function(DateTime) onSave,
  }) {
    final l10n = AppLocalizations.of(context)!;
    DateTime tempDate = currentDate ?? DateTime.now();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.dividerLighter,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.textPrimary,
                        size: 24,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        onSave(tempDate);
                        Navigator.pop(context);
                      },
                      child: Text(
                        l10n.save,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.infoBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Picker
              SizedBox(
                height: 220,
                child: CustomDatePicker(
                  initialDate: tempDate,
                  onDateChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
              const SafeArea(child: SizedBox(height: 16)),
            ],
          ),
        );
      },
    );
  }

  void _showVaccinationDatePickerBottomSheet() {
    final l10n = AppLocalizations.of(context)!;
    DateTime tempDate = _petVaccinationDate ?? DateTime.now();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.dividerLighter,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.textPrimary,
                        size: 24,
                      ),
                    ),
                    Text(
                      l10n.vaccinationDate,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          _petVaccinationStatus = l10n.vacVaccinated;
                          _petVaccinationDate = tempDate;
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        l10n.save,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.infoBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Picker
              SizedBox(
                height: 220,
                child: CustomDatePicker(
                  initialDate: tempDate,
                  onDateChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
              // Forgot Vaccination Time Button
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    _petVaccinationStatus = l10n.vacVaccinated;
                    _petVaccinationDate = null;
                  });
                  Navigator.pop(context);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.forgotVaccinationTime,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryYellow,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.primaryYellow,
                      ),
                    ],
                  ),
                ),
              ),
              const SafeArea(child: SizedBox(height: 16)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormGroup(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildFormItem({
    required String label,
    required bool isRequired,
    required String hint,
    String? value,
    VoidCallback? onTap,
    bool showBorder = true,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          border: showBorder
              ? const Border(
                  bottom: BorderSide(color: AppColors.dividerLighter, width: 1),
                )
              : null,
        ),
        child: Row(
          children: [
            if (isRequired)
              const Text(
                '* ',
                style: TextStyle(color: AppColors.errorRed, fontSize: 15),
              ),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Text(
              (value != null && value.isNotEmpty) ? value : hint,
              style: TextStyle(
                color: (value != null && value.isNotEmpty)
                    ? AppColors.textPrimary
                    : AppColors.textHint,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textLight,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
