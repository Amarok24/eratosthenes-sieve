/*
  Sieve of Eratosthenes
  Author: Jan Prazak
  Project page: https://github.com/Amarok24
  Version: 1.0
  Date: 2021-04-22 (Dart implementation)

  License: The Unlicense. For more information, please refer to http://unlicense.org
  (A license with no conditions whatsoever which dedicates works to the public domain. Unlicensed works, modifications, and larger works may be distributed under different terms and without source code.)

  About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
*/

import "dart:math";

List<int> getPrimes(int maxLimit) {
  var field = [];
  var primes = [2];
  var currentPrime = 2;
  var currentIndex = 2;

  int stopAfter = sqrt(maxLimit).floor();
  // stopAfter = highest index after which no other primes
  // will be sieved (simplest code optimization)

  if (maxLimit < 2) {
    return [-1];
  } else if (maxLimit == 2) {
    return primes;
  }

  for (int i = 0; i <= maxLimit; i++) {
    field.add(i); // field will contain [0, 1, 2, 3, ... maxLimit]
  }

  while (currentPrime <= stopAfter) {
    // with maxLimit of 50 this will run up to currentPrime 7, not beyond

    currentIndex += currentPrime;
    while (currentIndex <= maxLimit) {
      field[currentIndex] = 0; // mark as removed from field
      currentIndex += currentPrime;
    }

    // now let's go to the the very next prime number in field
    currentIndex = currentPrime;
    while (true) {
      currentIndex++;
      if (field[currentIndex] != 0) {
        break; // break while loop
      }
    }

    currentPrime = currentIndex;
    primes.add(currentPrime);
  }

  // now let's populate the primes array with all remaining numbers from field
  currentIndex++;
  for (int i = currentIndex; i <= maxLimit; i++) {
    if (field[i] != 0) {
      primes.add(field[i]);
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

  intArray = getPrimes(maxNum);

  intArray.forEach((element) {
    print(element);
  });
}
