/*
  Sieve of Eratosthenes
  Author: Jan Prazak
  Project page: https://github.com/Amarok24/eratosthenes-sieve
  Version: 1.0
  Date: 2020-01-07

  License: The Unlicense. For more information, please refer to http://unlicense.org
  (A license with no conditions whatsoever which dedicates works to the public domain. Unlicensed works, modifications, and larger works may be distributed under different terms and without source code.)

  About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
*/

function primeNumbers(maxLimit) {
  let field = [];
  let primes = [2];
  let currentPrime = 2;
  let currentIndex = 2;

  // stopAfter = highest index after which no other primes
  // will be sieved (simplest code optimization)
  const stopAfter = Math.floor(Math.sqrt(maxLimit));

  if (maxLimit < 2) {
    throw new RangeError("maxLimit must be > 1");
  } else if (maxLimit === 2) {
    return primes;
  }

  for (let i = 0; i <= maxLimit; i++) {
    field.push(i);
    // field will contain [0, 1, 2, 3, ... maxLimit]
  }

  while (currentPrime <= stopAfter) {
    // With maxLimit of 50 this will run up to currentPrime 7, not beyond

    currentIndex += currentPrime;
    while (currentIndex <= maxLimit) {
      field[currentIndex] = 0; // mark as removed from field
      currentIndex += currentPrime;
    }

    // now let's go to the the very next prime number in field
    currentIndex = currentPrime;
    while (true) {
      currentIndex++;
      if (field[currentIndex] !== 0) {
        break; // break while loop
      }
    }

    currentPrime = currentIndex;
    primes.push(currentPrime);
  }

  // Now let's populate the primes array with all remaining numbers from field
  currentIndex++;
  for (let i = currentIndex; i <= maxLimit; i++) {
    if (field[i] !== 0) {
      primes.push(field[i]);
    }
  }

  return primes;
}


function logPrimeNumbers(maxLimit = 50) {
  let primesArray;

  try {
    primesArray = primeNumbers(maxLimit);
    primesArray.forEach((element) => {
      console.log(element);
    });
  } catch (e) {
    console.log(e); // This outputs "RangeError: maxLimit must be > 1"
  }
}


logPrimeNumbers(70);
