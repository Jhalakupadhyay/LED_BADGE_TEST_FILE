String hexToBinary(String hexString) {
  int decimal = int.parse(hexString, radix: 16); // Parse hex to decimal
  return decimal.toRadixString(2).padLeft(8, '0'); // Convert decimal to binary with padding
}

