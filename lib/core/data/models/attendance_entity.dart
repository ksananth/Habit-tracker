import 'package:objectbox/objectbox.dart';
import 'package:habittracker/core/data/models/habit_entity.dart';

@Entity()
class Attendance {
  @Id()
  int id = 0;

  final habit = ToOne<HabitE>();

  @Property(type: PropertyType.date)
  DateTime date;

  Attendance({
    this.id = 0,
    required this.date,
  });
}
