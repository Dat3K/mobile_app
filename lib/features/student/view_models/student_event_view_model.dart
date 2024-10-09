import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/event_service.dart';
import '../../../core/models/event.dart';
import 'package:get_it/get_it.dart';

final studentEventViewModelProvider = StateNotifierProvider<StudentEventViewModel, AsyncValue<List<Event>>>((ref) {
  return StudentEventViewModel(GetIt.instance<EventService>());
});

class StudentEventViewModel extends StateNotifier<AsyncValue<List<Event>>> {
  final EventService _eventService;

  StudentEventViewModel(this._eventService) : super(const AsyncValue.loading()) {
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

  Future<void> registerForEvent(String eventId) async {
    try {
      await _eventService.registerForEvent(eventId);
      await loadEvents(); // Reload events after registration
    } catch (e) {
      // Handle error (you might want to update the state or show an error message)
      print('Failed to register for event: $e');
    }
  }
}