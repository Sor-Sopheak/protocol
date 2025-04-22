import 'package:protocol_app/models/destination_route_model.dart';
import 'package:protocol_app/widgets/search_widget.dart';

final navItems = [
  const DestinationRouteModel('Event List', '/event'),
  const DestinationRouteModel('Participants List', '/participants')
];

final eventItems = ['Today Event', 'Upcoming Event', 'Past Event'];
final manageEventItems = ['Overview', 'ស្នើសុំសមាសភាពចូលរួម', 'Assign Seats'];
// final onboardingOption = ['View Detail', 'Edit'];
// final priorityOption = ['Low', 'Normal', 'High', 'Immediate'];

final List<String> tableHeader = [
  'នាម និង គោត្តនាម', // name
  'មុខតំណែង', //position
  'ចូលរួមជា', //joinas
];


class User extends Searchable {
  final String name;
  final String position;
  final String joinAs;

  User({required this.name, required this.position, required this.joinAs});

  @override
  String get displayValue => name;

  @override
  bool matches(String query) {
    return name.toLowerCase().contains(query.toLowerCase()) ||
        position.toLowerCase().contains(query.toLowerCase());
  }
}

final List<User> allUsers = [
  User(name: 'Alice Smith', position: 'minister', joinAs: 'President'),
  User(
      name: 'Bob Johnson',
      position: 'secretaries of state',
      joinAs: 'Participants'),
  User(
      name: 'Charlie Brown',
      position: 'under secretaries of state',
      joinAs: 'Participants'),
  User(name: 'David Lee', position: 'deputy governor', joinAs: 'Participants'),
  User(
      name: 'Eve Wilson', position: 'director general', joinAs: 'Participants'),
  User(
      name: 'Fiona Green',
      position: 'director general',
      joinAs: 'Participants'),
  User(
      name: 'George Adams',
      position: 'deputy director general',
      joinAs: 'Participants'),
  User(
      name: 'Hannah Baker',
      position: 'senior official',
      joinAs: 'Participants'),
  User(name: 'Ian Carter', position: 'senior official', joinAs: 'Participants'),
  User(
      name: 'Jane Davis', position: 'director general', joinAs: 'Participants'),
];
