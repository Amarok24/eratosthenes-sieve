/*
  Sieve of Eratosthenes - Euler's variation (Dart implementation)
  Author: Jan Prazak
  Project page: https://github.com/Amarok24/eratosthenes-sieve
  Version: 1.0
  Date: 2021-04-30

  License: The Unlicense.
  For more information, please refer to https://unlicense.org

  About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes#Euler's_sieve
*/

// @dart=2.12
import 'dart:collection';
import 'dart:io';
import "dart:math";

List<int> primeNumbers(int maxLimit, [bool toTerminal = false]) {
  Queue<int> field = Queue();
  List<int> verifiedPrimes = [];
  List<int> numbersToRemove = [];
  int currentPrime;
  int x = 2;

  // 'stopAfter' = highest index after which no other primes will be sieved (simplest code optimization).
  int stopAfter = sqrt(maxLimit).floor();

  if (maxLimit < 2) {
    throw new RangeError('maxLimit must be > 1');
  }

  for (int i = 2; i <= maxLimit; i++) {
    field.add(i);
  }

  while (x <= stopAfter) {
    currentPrime = field.removeFirst();
    verifiedPrimes.add(currentPrime);

    if (toTerminal) stdout.write('$currentPrime, ');

    numbersToRemove.add(currentPrime * currentPrime);

    for (int i in field) {
      int r = currentPrime * i;

      if (r > field.last) {
        break;
      }

      numbersToRemove.add(r);
    }

    numbersToRemove.forEach((n) {
      field.remove(n);
    });

    numbersToRemove.clear();

    x++;
  }

  for (int i in field) {
    verifiedPrimes.add(i);
  }

  if (toTerminal) {
    for (int i in field) {
      stdout.write('$i, ');
    }
  }

  return verifiedPrimes;
}

void main(List<String> arguments) {
  int maxNum = 53;
  List<int> intArray = [];

  if (arguments.isNotEmpty) {
    maxNum = int.parse(arguments[0]);
  }

  try {
    intArray = primeNumbers(maxNum);

    intArray.forEach((element) {
      stdout.write('$element, ');
    });
  } catch (e) {
    print(e); // This prints: "RangeError: maxLimit must be > 1".
  }
}
