/*
  Sieve of Eratosthenes (C++ implementation)
  Author: Jan Prazak
  Project page: https://github.com/Amarok24/eratosthenes-sieve
  Version: 1.0
  Date: 2021-04-27

  License: The Unlicense. For more information, please refer to http://unlicense.org
  (A license with no conditions whatsoever which dedicates works to the public domain. Unlicensed works, modifications, and larger works may be distributed under different terms and without source code.)

  About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
*/

#include <iostream>
#include <string>
#include <cmath>
#include <vector>

using namespace std;

vector<int> primeNumbers(const int maxLimit) {
  vector<int> field; // A growable list (array)
  vector<int> primes = {2}; // Initial value 2
  int currentPrime = 2;
  int currentIndex = 2;

  // stopAfter = highest index after which no other primes will be sieved
  // (simplest code optimization).
  // Type casting to int truncates the fractional part (similar to using trunc).
  int stopAfter = (int)sqrt( (double)maxLimit );

  if (maxLimit < 2) {
    throw "maxLimit must be > 1";
  } else if (maxLimit == 2) {
    return primes;
  }

  for (int i = 0; i <= maxLimit; i++) {
    field.push_back(i);
    // field will contain [0, 1, 2, 3, ... maxLimit]
  }

  while (currentPrime <= stopAfter) {
    // With maxLimit of 50 this will run up to currentPrime 7, not beyond
    currentIndex += currentPrime;
    while (currentIndex <= maxLimit) {
      field[currentIndex] = 0; // mark as removed from field
      currentIndex += currentPrime;
    }

    // Now let's go to the the very next prime number in field.
    currentIndex = currentPrime;
    while (true) {
      currentIndex++;
      if (field[currentIndex] != 0) {
        break; // break while loop
      }
    }

    currentPrime = currentIndex;
    primes.push_back(currentPrime);
  }

  // Now let's populate the primes array with all remaining numbers from field.
  currentIndex++;
  for (int i = currentIndex; i <= maxLimit; i++) {
    if (field[i] != 0) {
      primes.push_back(field[i]);
    }
  }

  return primes;
}

int main(int argc, char * argv[]) {
  int maxNum = 50;
  vector<int> intArray;

  if (argc > 1) {
    maxNum = stoi(argv[1]); // String to integer.
  }

  try {
    intArray = primeNumbers(maxNum);
    for (int i = 0; i < intArray.size(); i++) {
      cout << intArray[i] << endl;
    }
  } catch (const char * msg) {
    // This prints: "maxLimit must be > 1"
    cout << msg << endl;
  }
}
