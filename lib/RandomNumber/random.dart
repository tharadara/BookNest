import 'dart:math';

void main() {
  var rng = Random();
  String ticketNumber = generateTicketNumber(rng, 10); // Adjust the length as needed
  print(ticketNumber); // Example output: TICKET-A1B2C3D4E5
}

String generateTicketNumber(Random rng, int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return 'TICKET-' + List.generate(length, (index) => chars[rng.nextInt(chars.length)]).join();
}
