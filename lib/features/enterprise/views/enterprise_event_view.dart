import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/enterprise_event_view_model.dart';
import '../../../core/models/event.dart';
import '../../../core/utils/localization.dart';

class EnterpriseEventView extends ConsumerWidget {
  const EnterpriseEventView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsState = ref.watch(enterpriseEventViewModelProvider);
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
              onEdit: () => _showEventDialog(context, ref, event: event),
              onDelete: () {
                ref.read(enterpriseEventViewModelProvider.notifier).deleteEvent(event.id);
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEventDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEventDialog(BuildContext context, WidgetRef ref, {Event? event}) {
    showDialog(
      context: context,
      builder: (context) => EventDialog(
        event: event,
        onSave: (newEvent) {
          if (event == null) {
            ref.read(enterpriseEventViewModelProvider.notifier).createEvent(newEvent);
          } else {
            ref.read(enterpriseEventViewModelProvider.notifier).updateEvent(newEvent);
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  final Event event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EventListItem({
    super.key,
    required this.event,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(event.title),
        subtitle: Text('${event.startDate.toLocal()} - ${event.endDate.toLocal()}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class EventDialog extends StatefulWidget {
  final Event? event;
  final Function(Event) onSave;

   const EventDialog({super.key, this.event, required this.onSave});

  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event?.title ?? '');
    _descriptionController = TextEditingController(text: widget.event?.description ?? '');
    _startDate = widget.event?.startDate ?? DateTime.now();
    _endDate = widget.event?.endDate ?? DateTime.now().add(const Duration(hours: 1));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(widget.event == null ? l10n.createEvent : l10n.editEvent),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            ListTile(
              title: const Text('Start Date'),
              subtitle: Text(_startDate.toString()),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _startDate = date);
                }
              },
            ),
            ListTile(
              title: const Text('End Date'),
              subtitle: Text(_endDate.toString()),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _endDate,
                  firstDate: _startDate,
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _endDate = date);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final event = Event(
              id: widget.event?.id ?? '',
              title: _titleController.text,
              description: _descriptionController.text,
              startDate: _startDate,
              endDate: _endDate,
              eventType: 'general',
              status: 'active',
            );
            widget.onSave(event);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}