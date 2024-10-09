import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/event_service.dart';
import '../../../core/models/event.dart';
import 'package:get_it/get_it.dart';

final enterpriseEventViewModelProvider = StateNotifierProvider<EnterpriseEventViewModel, AsyncValue<List<Event>>>((ref) {
  return EnterpriseEventViewModel(GetIt.instance<EventService>());
});

class EnterpriseEventViewModel extends StateNotifier<AsyncValue<List<Event>>> {
  final EventService _eventService;

  EnterpriseEventViewModel(this._eventService) :

 super(const AsyncValue.loading()) {
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final events = await _eventService.getEvents();
      state = AsyncValue.data(events);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createEvent(Event event) async {
    try {
      await _eventService.createEvent(event);
      await loadEvents(); // Reload events after creation
    } catch (e) {
      // Handle error (you might want to update the state or show an error message)
      print('Failed to create event: $e');
    }
  }

  Future<void> updateEvent(Event event) async {
    try {
      await _eventService.updateEvent(event);
      await loadEvents(); // Reload events after update
    } catch (e) {
      // Handle error (you might want to update the state or show an error message)
      print('Failed to update event: $e');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _eventService.deleteEvent(eventId);
      await loadEvents(); // Reload events after deletion
    } catch (e) {
      // Handle error (you might want to update the state or show an error message)
      print('Failed to delete event: $e');
    }
  }
}