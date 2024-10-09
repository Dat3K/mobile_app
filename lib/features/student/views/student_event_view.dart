import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/student_event_view_model.dart';
import '../../../core/models/event.dart';
import '../../../core/utils/localization.dart';

class StudentEventView extends ConsumerWidget {
  const StudentEventView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsState = ref.watch(studentEventViewModelProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.events)),
      body: eventsState.when(
        data: (events) => ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return EventListItem(
              event: event,
              onRegister: () {
                ref.read(studentEventViewModelProvider.notifier).registerForEvent(event.id);
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  final Event event;
  final VoidCallback onRegister;

  const EventListItem({
    super.key,
    required this.event,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(event.title),
        subtitle: Text('${event.startDate.toLocal()} - ${event.endDate.toLocal()}'),
        trailing: ElevatedButton(
          onPressed: onRegister,
          child: Text(l10n.registerForEvent),
        ),
      ),
    );
  }
}