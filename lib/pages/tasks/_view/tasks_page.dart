import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/model/task.dart';
import 'package:task_list_app/service/network_service.dart';

final selectedTaskProvider = StateProvider<Task?>((ref) => null);

final tasksProvider = FutureProvider.autoDispose<List<Task>>((ref) async {
  final networkService = ref.read(networkServiceProvider);
  return networkService.getTasks();
});

class TasksPage extends ConsumerWidget {
  TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsyncValue = ref.watch(tasksProvider);
    final selectedTask = ref.watch(selectedTaskProvider);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("task".tr()),
          SizedBox(height: 24),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: tasksAsyncValue.when(
                    data: (tasks) {
                      return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return GestureDetector(
                            onTap: () {
                              ref.read(selectedTaskProvider.notifier).state =
                                  task;
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: selectedTask == task
                                    ? Colors.blue.withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "task".tr() + " ${index + 1}",
                                      style: TextStyle(
                                        color: selectedTask == task
                                            ? Colors.blue
                                            : null,
                                      ),
                                    ),
                                  ),
                                  Text(DateFormat('MM/dd, hh:mm',
                                          context.locale.languageCode)
                                      .format(task.dateTime!))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => CircularProgressIndicator(),
                    error: (error, stackTrace) => Text('Error: $error'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                Expanded(
                  key: Key("desc"),
                  child: Consumer(
                    builder: (context, ref, _) {
                      if (selectedTask != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'task'.tr() + " ${selectedTask.id ?? ""}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(selectedTask.title ?? ""),
                          ],
                        );
                      }
                      return Container(); // Empty container when no task is selected
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
