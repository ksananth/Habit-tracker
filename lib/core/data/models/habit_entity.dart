import 'package:objectbox/objectbox.dart';

@Entity()
class HabitE {
  @Id()
  int id = 0;

  String name;

  @Property(type: PropertyType.date)
  DateTime? createdDate;

  @Property(type: PropertyType.date)
  DateTime startDate;

  @Property(type: PropertyType.date)
  DateTime? endDate;

  HabitE({
    this.id = 0,
    required this.name,
    required this.startDate,
    this.endDate,
  });
}
