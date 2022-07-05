/*
  Sieve of Eratosthenes (C++ implementation, vector of booleans)
  Author: Jan Prazak
  Project page: https://github.com/Amarok24/eratosthenes-sieve
  Version: 1.0
  Date: 2021-05-03

  License: The Unlicense.
  For more information, please refer to https://unlicense.org

  About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
*/

#include <iostream>
#include <string>
#include <cmath>
#include <vector>

using namespace std;

vector<int> primeNumbers(const int maxLimit) {
  vector<bool> field(maxLimit + 1, true); // All indexes initialized to 'true'.
  vector<int> primes = {2}; // Initial value 2.
  int currentPrime = 2;
  int currentIndex = 2;

  // 'stopAfter' = highest index after which no other primes will be sieved
  // (simplest code optimization).
  // Type casting to int truncates the fractional part (similar to using trunc).
  int stopAfter = (int) sqrt((double) maxLimit);

  if (maxLimit < 2) {
    throw "maxLimit must be > 1";
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
    primes.push_back(currentPrime);
  }

  // Now let's populate the primes array with all remaining numbers from field.
  currentIndex++;
  for (int i = currentIndex; i <= maxLimit; i++) {
    if (field[i] == true) {
      primes.push_back(i);
    }
  }

  return primes;
}

int main(int argc, char* argv[]) {
  int maxNum = 50;
  vector<int> intArray;

  if (argc > 1) {
    maxNum = stoi(argv[1]); // String to integer.
  }

  try {
    intArray = primeNumbers(maxNum);
    for (int i = 0; i < intArray.size(); i++) {
      cout << intArray[i] << ", ";
    }
    cout << endl;
  } catch (const char* msg) {
    // This prints: "maxLimit must be > 1".
    cerr << msg << endl;
  }
}
