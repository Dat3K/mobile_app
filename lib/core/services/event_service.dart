import 'package:hive/hive.dart';
import '../api/api_client.dart';
import '../models/event.dart';

class EventService {
  final ApiClient _apiClient;

  EventService(this._apiClient);

  Future<List<Event>> getEvents() async {
    try {
      final box = Hive.box<Event>('events');
      if (box.isNotEmpty) {
        return box.values.toList();
      }

      final response = await _apiClient.get('/events');
      final events = (response.data as List).map((e) => Event.fromJson(e)).toList();

      await box.clear();
      await box.addAll(events);

      return events;
    } catch (e) {
      throw Exception('Failed to get events: $e');
    }
  }

  Future<Event> createEvent(Event event) async {
    try {
      final response = await _apiClient.post('/events', data: event.toJson());
      final createdEvent = Event.fromJson(response.data);

      final box = Hive.box<Event>('events');
      await box.add(createdEvent);

      return createdEvent;
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  Future<Event> updateEvent(Event event) async {
    try {
      final response = await _apiClient.put('/events/${event.id}', data: event.toJson());
      final updatedEvent = Event.fromJson(response.data);

      final box = Hive.box<Event>('events');
      final index = box.values.toList().indexWhere((e) => e.id == event.id);
      await box.putAt(index, updatedEvent);

      return updatedEvent;
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _apiClient.delete('/events/$eventId');

      final box = Hive.box<Event>('events');
      final index = box.values.toList().indexWhere((e) => e.id == eventId);
      await box.deleteAt(index);
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  Future<void> registerForEvent(String eventId) async {
    try {
      await _apiClient.post('/events/$eventId/register');
    } catch (e) {
      throw Exception('Failed to register for event: $e');
    }
  }
}