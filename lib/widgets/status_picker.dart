import 'package:dynamic_ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Map<String, Color> statusColors = {
  'in progress': Colors.orange,
  'done': Colors.green,
  'failed': Colors.red,
  'deleted': Colors.grey,
};

class StatusPicker extends ConsumerStatefulWidget {
  const StatusPicker({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  ConsumerState<StatusPicker> createState() => _StatusPickerState();
}

class _StatusPickerState extends ConsumerState<StatusPicker> {
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.read(themeManagerProvider);
    final size = MediaQuery.of(context).size;

    final statusOptions = ['in progress', 'done', 'failed', 'deleted'];

    return SizedBox(
      width: size.width * 0.5,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemCount: statusOptions.length,
        itemBuilder: (context, index) {
          final status = statusOptions[index];
          print('status: $status');
          final isSelected = status == selectedStatus;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedStatus = status;
              });
              widget.controller.text = status;
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? statusColors[status] : Colors.transparent,
                border: Border.all(
                  color: statusColors[status]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  status,
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: isSelected ? Colors.white : statusColors[status],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
