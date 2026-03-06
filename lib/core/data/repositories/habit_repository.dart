import 'package:habittracker/core/data/repositories/domain/habit.dart';
import 'package:habittracker/core/data/models/habit_entity.dart';
import 'package:habittracker/objectbox.g.dart';

abstract class HabitRepository {
  Future<int> add(Habit habit);
  Future<Habit?> getById(int id);
  Future<List<Habit>> getAll();
  Future<bool> delete(int id);
  Future<void> deleteAll();
}

class HabitRepositoryImpl implements HabitRepository {
  final Box<HabitE> _box;

  HabitRepositoryImpl(Store store) : _box = store.box<HabitE>();

  @override
  Future<int> add(Habit habit) async {
    final entity = HabitE(
      id: habit.id,
      name: habit.name,
      startDate: habit.startDate,
      endDate: habit.endDate,
    )..createdDate = habit.createdDate;
    return _box.put(entity);
  }

  @override
  Future<Habit?> getById(int id) async {
    final entity = _box.get(id);
    return entity != null ? _toHabit(entity) : null;
  }

  @override
  Future<List<Habit>> getAll() async {
    return _box.getAll().map(_toHabit).toList();
  }

  @override
  Future<bool> delete(int id) async => _box.remove(id);

  @override
  Future<void> deleteAll() async => _box.removeAll();

  Habit _toHabit(HabitE entity) {
    return Habit(
      id: entity.id,
      name: entity.name,
      createdDate: entity.createdDate,
      startDate: entity.startDate,
      endDate: entity.endDate,
    );
  }
}
