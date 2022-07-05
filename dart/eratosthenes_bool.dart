/*
  Sieve of Eratosthenes (Dart implementation, list of booleans)
  Author: Jan Prazak
  Project page: https://github.com/Amarok24/eratosthenes-sieve
  Version: 1.0
  Date: 2021-05-26

  License: The Unlicense.
  For more information, please refer to https://unlicense.org

  About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
*/

// @dart=2.12
import 'dart:math';

List<int> primeNumbers(int maxLimit) {
  // A fixed-length list (array) of booleans initialized to "true".
  List<bool> field = new List<bool>.filled(maxLimit + 1, true);
  List<int> primes = [2]; // A growable list (array) holding value 2
  int currentPrime = 2;
  int currentIndex = 2;

  // stopAfter = highest index after which no other primes will be sieved (simplest code optimization)
  int stopAfter = sqrt(maxLimit).floor();

  if (maxLimit < 2) {
    throw new RangeError('maxLimit must be > 1');
  } else if (maxLimit == 2) {
    return primes;
  }

  while (currentPrime <= stopAfter) {
    // With maxLimit of 50 this will run up to currentPrime 7, not beyond.
    currentIndex += currentPrime;
    while (currentIndex <= maxLimit) {
      field[currentIndex] = false; // Mark as non-prime.
      currentIndex += currentPrime;
    }

    // Now let's go to the the very next prime number in field.
    currentIndex = currentPrime;
    while (true) {
      currentIndex++;
      if (field[currentIndex] == true) {
        break; // Next prime found, break the while-loop.
      }
    }

    currentPrime = currentIndex;
    primes.add(currentPrime);
  }

  // Now let's populate the primes array with all remaining numbers from field.
  // I'm not sure how efficient this is in Dart (accessing indexes of a boolean field).
  currentIndex++;
  for (int i = currentIndex; i <= maxLimit; i++) {
    if (field[i] == true) {
      primes.add(i);
    }
  }

  return primes;
}

void main(List<String> arguments) {
  int maxNum = 50;
  List<int> intArray = [];

  if (arguments.isNotEmpty) {
    maxNum = int.parse(arguments[0]);
  }

  try {
    intArray = primeNumbers(maxNum);
    intArray.forEach((element) {
      print(element);
    });
  } catch (e) {
    print(e); // This prints "RangeError: maxLimit must be > 1"
  }
}
