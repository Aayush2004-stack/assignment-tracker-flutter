import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/widgets/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> get weekDates {
    final daysFromSunday = selectedDate.weekday % 7;
    final startOfWeek = selectedDate.subtract(Duration(days: daysFromSunday));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: DateFormat('MMMM').format(selectedDate)),
                      CustomText(
                        text: DateFormat('EEEE,  d').format(selectedDate),
                      ),
                    ],
                  ),
                  Icon(Icons.calendar_month_outlined),
                ],
              ),
              SizedBox(height: 20),
              _buildWeekCalendar(),
              SizedBox(height: 20),
              CustomText(text: "Assignmnets for today"),

              SizedBox(height: 20),
              AssignmentCard(),
              SizedBox(height: 20),
              AssignmentCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeekCalendar() {
    return Container(
      padding: const EdgeInsets.all(5),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: const Color.fromARGB(93, 72, 71, 71)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: weekDates.map((date) {
          final isSelected =
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;

          return _buildDateItem(date: date, isSelected: isSelected);
        }).toList(),
      ),
    );
  }

  Widget _buildDateItem({required DateTime date, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = date;
        });
      },

      child: Container(
        width: 48,

        height: 76,

        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(142, 0, 0, 0)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              DateFormat('E').format(date).substring(0, 1),

              style: TextStyle(
                fontSize: 14,

                fontWeight: FontWeight.w600,

                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              DateFormat('d').format(date),

              style: TextStyle(
                fontSize: 20,

                fontWeight: FontWeight.w600,

                color: isSelected ? Colors.white : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
