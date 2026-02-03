import 'package:flutter/material.dart';
import 'package:flutter_test_app/core/theme/app_pallet.dart';
import 'package:flutter_test_app/presentation/widgets/text_area.dart';
import 'package:flutter_test_app/presentation/widgets/section.dart';
import 'package:flutter_test_app/presentation/widgets/segmented_tab.dart';
import 'package:intl/intl.dart';

import '../cotrollers/mood_controller.dart';
import '../models/mood.dart';
import 'date_picker.dart';
import 'widgets/slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final MoodDiaryController controller;
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = MoodDiaryController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Center(
                            child: Text(
                                DateFormat("d MMMM HH:mm", "ru").format(controller.date),
                                style: const TextStyle(
                                    color: AppPallet.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        IconButton(
                          onPressed: () async => await DatePicker.pickDate(
                              context,
                              onSelected: controller.setDate),
                          icon: const Icon(Icons.calendar_month_rounded,
                              color: AppPallet.grey),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: OverlaySegmentedTabs(
                        selectedIndex: controller.currentIndex,
                        onTap: controller.onTabTapped,
                      ),
                    ),
                  ),
                ),

                if (controller.currentIndex == 1)
                  const SliverToBoxAdapter(
                    child: Center(child: Text("Статистики")),
                  )
                else ...[
                  SliverToBoxAdapter(
                    child: SectionWidget(
                      label: "Что чувствуешь?",
                      children: [
                        SizedBox(
                          height: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Mood.values.length,
                            itemBuilder: (context, index) {
                              final mood = Mood.values[index];
                              final isSelected = controller.currentMood == mood;
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () => controller.selectMood(mood),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppPallet.orange
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/${mood.asset}",
                                          width: 64,
                                          height: 64,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(mood.text),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (controller.currentMood == Mood.happy)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: moodState.asMap().entries.map((entry) {
                              final idx = entry.key;
                              final label = entry.value;
                              final isSelected =
                                  controller.moodStateIndex == idx;

                              return ChoiceChip(
                                label: Text(label),
                                selected: isSelected,
                                onSelected: (_) => controller.setMoodState(idx),
                                selectedColor: AppPallet.orange,
                                backgroundColor: Colors.grey.shade200,
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                                showCheckmark: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: isSelected
                                        ? AppPallet.orange
                                        : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SectionWidget(
                      label: "Уровень стресса",
                      children: [
                        LabeledDiscreteSlider(
                          leftLabel: "Низкий",
                          rightLabel: "Высокий",
                          value: controller.stress,
                          onChanged: controller.setStress,
                        ),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SectionWidget(
                      label: "Самооценка",
                      children: [
                        LabeledDiscreteSlider(
                          leftLabel: "Неуверенность",
                          rightLabel: "Уверенность",
                          value: controller.selfEsteem,
                          onChanged: controller.setSelfEsteem,
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SectionWidget(
                      label: "Заметки",
                      children: [
                        TextAreaCard(
                          textEditingController: noteController,
                          onChanged: () =>
                              controller.setNotes(noteController.text.trim()),
                        ),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.validate()? AppPallet.orange: Colors.white,
                          foregroundColor: controller.validate()? Colors.white : AppPallet.grey,
                        ),
                        onPressed:()=> controller.save(context),
                        child: const Text("Сохранить"),
                      ),
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}