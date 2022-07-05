/*
 * Sieve of Eratosthenes (TypeScript implementation)
 * Version: 1.0.1
 * Date: 2021-04-26, 2022-07-05
 * Author: Jan Prazak
 * Project page: https://github.com/Amarok24/eratosthenes-sieve
 *
 * This is a CLI version made to run with Deno (https://deno.land/).
 * Usage: deno run eratosthenes.ts 1000
 *
 * License: The Unlicense.
 * For more information, please refer to https://unlicense.org
 *
 * About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
 */

function primeNumbers(maxLimit: number): number[] | never {

  let field: number[] = [];
  let primes: number[] = [2];
  let currentPrime: number = 2;
  let currentIndex: number = 2;

  // stopAfter = highest index after which no other primes will be sieved (simplest code optimization)
  const stopAfter: number = Math.floor(Math.sqrt(maxLimit));

  if (maxLimit < 2) {
    throw new RangeError("maxLimit must be > 1");
  }
  else if (maxLimit === 2) {
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

    // Now let's go to the the very next prime number in field
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

  // Populate the primes array with all remaining numbers from field
  currentIndex++;
  for (let i = currentIndex; i <= maxLimit; i++) {
    if (field[i] !== 0) {
      primes.push(field[i]);
    }
  }

  return primes;
}


function logPrimeNumbers(maxLimit: number = 50): void | never {

  let primesArray: number[];

  try {
    primesArray = primeNumbers(maxLimit);
    primesArray.forEach((element) => {
      console.log(element);
    });
  }
  catch (e: unknown) {
    console.log(e); // This outputs "RangeError: maxLimit must be > 1"
  }
}

let args: string[] = [];

args = Deno.args; // Use this for Deno runtime.
//args = process.argv; // Use this for NodeJS runtime.

if (args.length) {
  logPrimeNumbers(parseInt(args[0]));
}
else {
  logPrimeNumbers();
}
