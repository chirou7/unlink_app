import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../widgets/common_app_bar.dart';
import '../models/pet_breed.dart';

enum PetType { dog, cat }

class PetBreedSelectionPage extends StatefulWidget {
  final String? currentSelectedName;
  final PetType defaultType;

  const PetBreedSelectionPage({
    super.key,
    this.currentSelectedName,
    this.defaultType = PetType.dog,
  });

  @override
  State<PetBreedSelectionPage> createState() => _PetBreedSelectionPageState();
}

class _PetBreedSelectionPageState extends State<PetBreedSelectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _debounceTimer;

  final ScrollController _scrollController = ScrollController();

  late List<PetBreed> _allDogs;
  late List<PetBreed> _allCats;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.defaultType == PetType.dog ? 0 : 1,
    );

    _allDogs = PetBreed.mockDogs();
    _allCats = PetBreed.mockCats();

    _searchController.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _searchQuery = _searchController.text.trim().toLowerCase();
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Widget _buildGlobalSearchResults(AppLocalizations l10n) {
    final allBreeds = [..._allDogs, ..._allCats];
    final filtered = allBreeds.where((breed) {
      return breed.name.toLowerCase().contains(_searchQuery) ||
          breed.alias.toLowerCase().contains(_searchQuery) ||
          breed.pinyin.contains(_searchQuery);
    }).toList();

    if (filtered.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: AppColors.textLight),
            const SizedBox(height: 16),
            Text(
              l10n.searchEmptyHint,
              style: const TextStyle(
                color: AppColors.textTertiary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                HapticFeedback.selectionClick();
                Navigator.pop(context, '混血/串串');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryYellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 0,
                minimumSize: const Size(double.infinity, 44),
              ),
              child: Text(
                l10n.selectMixedBreed,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                HapticFeedback.selectionClick();
                Navigator.pop(context, '不确定/未知品种');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.dividerLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: const Size(double.infinity, 44),
              ),
              child: Text(
                l10n.selectUnknownBreed,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final breed = filtered[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.vertical(
              top: index == 0 ? const Radius.circular(12) : Radius.zero,
              bottom: index == filtered.length - 1
                  ? const Radius.circular(12)
                  : Radius.zero,
            ),
          ),
          child: _buildBreedItem(
            breed,
            isFirst: index == 0,
            isLast: index == filtered.length - 1,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: CommonAppBar(
        title: l10n.selectBreed,
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),
      body: Column(
        children: [
          // TabBar
          if (_searchQuery.isEmpty)
            Container(
              color: AppColors.backgroundWhite,
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textHint,
                indicatorColor: AppColors.primaryYellow,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                onTap: (index) {
                  HapticFeedback.selectionClick();
                  // Clear search query when switching tabs
                  _searchController.clear();
                  FocusScope.of(context).unfocus();
                },
                tabs: [
                  Tab(text: l10n.tabDog),
                  Tab(text: l10n.tabCat),
                ],
              ),
            ),

          // Search Bar
          Container(
            color: AppColors.backgroundWhite,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: l10n.searchBreedHint,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textHint,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textHint,
                    size: 20,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: AppColors.textHint,
                            size: 16,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            HapticFeedback.selectionClick();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Container(
              color: AppColors.backgroundLight,
              child: _searchQuery.isNotEmpty
                  ? _buildGlobalSearchResults(l10n)
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildPetList(PetType.dog, l10n),
                        _buildPetList(PetType.cat, l10n),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetList(PetType type, AppLocalizations l10n) {
    final breeds = type == PetType.dog ? _allDogs : _allCats;

    if (breeds.isEmpty) {
      return Center(
        child: Text(
          l10n.noData,
          style: const TextStyle(color: AppColors.textHint, fontSize: 14),
        ),
      );
    }

    // Normal state: Hot + All
    final hotBreeds = breeds.where((b) => b.isHot).toList();
    final normalBreeds = breeds.where((b) => !b.isHot).toList();

    // Sort normal breeds by pinyin
    normalBreeds.sort((a, b) => a.pinyin.compareTo(b.pinyin));

    // Group by first letter
    final Map<String, List<PetBreed>> groupedBreeds = {};
    for (var breed in normalBreeds) {
      final letter = breed.firstLetter;
      groupedBreeds.putIfAbsent(letter, () => []).add(breed);
    }

    final sortedLetters = groupedBreeds.keys.toList()..sort();

    // We will build a single list of widgets for the ScrollView
    List<Widget> listItems = [];

    // 1. Hot Breeds
    if (hotBreeds.isNotEmpty) {
      listItems.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Text(
            l10n.hotRecommendation,
            style: const TextStyle(fontSize: 14, color: AppColors.textTertiary),
          ),
        ),
      );
      listItems.add(
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: List.generate(hotBreeds.length, (index) {
              return _buildBreedItem(
                hotBreeds[index],
                isFirst: index == 0,
                isLast: index == hotBreeds.length - 1,
              );
            }),
          ),
        ),
      );
      listItems.add(const SizedBox(height: 24));
    }

    // 2. All Breeds Title
    listItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4),
        child: Text(
          l10n.allBreeds,
          style: const TextStyle(fontSize: 14, color: AppColors.textTertiary),
        ),
      ),
    );

    // 3. Grouped Breeds
    for (var letter in sortedLetters) {
      final letterBreeds = groupedBreeds[letter]!;
      listItems.add(
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Text(
            letter,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      );
      listItems.add(
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: List.generate(letterBreeds.length, (index) {
              return _buildBreedItem(
                letterBreeds[index],
                isFirst: index == 0,
                isLast: index == letterBreeds.length - 1,
              );
            }),
          ),
        ),
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            32,
            12,
          ), // Extra padding on right for A-Z
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listItems,
          ),
        ),
        // A-Z Index Sidebar
        Positioned(
          right: 4,
          top: 0,
          bottom: 0,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: sortedLetters.map((letter) {
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    // In a real app, you would calculate exact scroll offsets.
                    // For now, we approximate or just rely on the user scrolling.
                    // To do this perfectly we'd need GlobalKeys for each section.
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: 8.0,
                    ),
                    child: Text(
                      letter,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreedItem(
    PetBreed breed, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final isSelected = breed.name == widget.currentSelectedName;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.pop(context, breed.name);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(
                  bottom: BorderSide(color: AppColors.dividerLighter, width: 1),
                ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                breed.displayName,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected
                      ? AppColors.primaryYellow
                      : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, color: AppColors.primaryYellow, size: 20),
          ],
        ),
      ),
    );
  }
}
