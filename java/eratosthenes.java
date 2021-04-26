/*
  Sieve of Eratosthenes (Java implementation)
  Author: Jan Prazak
  Project page: https://github.com/Amarok24/eratosthenes-sieve
  Version: 1.0
  Date: 2021-04-26

  License: The Unlicense. For more information, please refer to http://unlicense.org
  (A license with no conditions whatsoever which dedicates works to the public domain. Unlicensed works, modifications, and larger works may be distributed under different terms and without source code.)

  About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
*/

import java.util.ArrayList;

class Main {

  public static ArrayList <Integer> primeNumbers(int maxLimit) {
    ArrayList<Integer> field = new ArrayList<Integer>(); // A growable list (array)
    ArrayList<Integer> primes = new ArrayList<Integer>();
    int currentPrime = 2;
    int currentIndex = 2;

    primes.add(2);

    // stopAfter = highest index after which no other primes will be sieved
    // (simplest code optimization)
    int stopAfter = (int) Math.floor(Math.sqrt(maxLimit));

    if (maxLimit < 2) {
      throw new ArithmeticException("maxLimit must be > 1");
    } else if (maxLimit == 2) {
      return primes;
    }

    for (int i = 0; i <= maxLimit; i++) {
      field.add(i);
      // field will contain [0, 1, 2, 3, ... maxLimit]
    }

    while (currentPrime <= stopAfter) {
      // With maxLimit of 50 this will run up to currentPrime 7, not beyond

      currentIndex += currentPrime;
      while (currentIndex <= maxLimit) {
        field.set(currentIndex, 0); // mark as removed from field
        currentIndex += currentPrime;
      }

      // Now let's go to the the very next prime number in field.
      currentIndex = currentPrime;
      while (true) {
        currentIndex++;
        if (field.get(currentIndex) != 0) {
          break; // break while loop
        }
      }

      currentPrime = currentIndex;
      primes.add(currentPrime);
    }

    // Now let's populate the primes array with all remaining numbers from field.
    currentIndex++;

    for (int i = currentIndex; i <= maxLimit; i++) {
      if (field.get(i) != 0) {
        primes.add(field.get(i));
      }
    }

    return primes;
  }

  public static void main(String[] args) {
    int maxNum = 50;
    ArrayList<Integer> intArray = new ArrayList<Integer>();

    if (args.length > 0) {
      maxNum = Integer.parseInt(args[0]);
    }

    try {
      intArray = primeNumbers(maxNum);
      for (int element: intArray) {
        System.out.println(element);
      }
    } catch (Exception e) {
      // This prints "java.lang.ArithmeticException: maxLimit must be > 1"
      System.out.println(e);
    }
  }
}
