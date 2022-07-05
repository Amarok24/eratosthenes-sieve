/*
  Sieve of Eratosthenes (C# implementation)
  Author: Jan Prazak
  Project page: https://github.com/Amarok24/eratosthenes-sieve
  Version: 1.0
  Date: 2021-04-27

  License: The Unlicense.
  For more information, please refer to https://unlicense.org

  About the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
*/

using System;
using System.Collections.Generic;

class Eratosthenes
{
	static List<int> primeNumbers(int maxLimit)
	{
		List<int> field = new List<int>(); // A growable list (array)
		List<int> primes = new List<int>();
		int currentPrime = 2;
		int currentIndex = 2;

		// stopAfter = highest index after which no other primes will be sieved
		// (simplest code optimization). In C# Math.floor() returns type 'double'.
    // Type casting to int truncates the fractional part (same as using Math.Floor).
		int stopAfter = (int)Math.Sqrt(maxLimit);

		primes.Add(2);

		if (maxLimit < 2)
		{
			throw new ArgumentOutOfRangeException("maxLimit", "maxLimit must be > 1");
		}
		else if (maxLimit == 2)
		{
			return primes;
		}

		for (int i = 0; i <= maxLimit; i++)
		{
			field.Add(i);
		// field will contain [0, 1, 2, 3, ... maxLimit]
		}

		while (currentPrime <= stopAfter)
		{
			// With maxLimit of 50 this will run up to currentPrime 7, not beyond
			currentIndex += currentPrime;
			while (currentIndex <= maxLimit)
			{
				field[currentIndex] = 0; // mark as removed from field
				currentIndex += currentPrime;
			}

			// Now let's go to the the very next prime number in field.
			currentIndex = currentPrime;
			while (true)
			{
				currentIndex++;
				if (field[currentIndex] != 0)
				{
					break; // break while loop
				}
			}

			currentPrime = currentIndex;
			primes.Add(currentPrime);
		}

		// Now let's populate the primes array with all remaining numbers from field.
		currentIndex++;
		for (int i = currentIndex; i <= maxLimit; i++)
		{
			if (field[i] != 0)
			{
				primes.Add(field[i]);
			}
		}

		return primes;
	}

	static void Main(string[] args)
	{
		int maxNum = 50;
		List<int> intArray = new List<int>();

		if (args.Length > 0)
		{
			maxNum = Int32.Parse(args[0]);
		}

		try
		{
			intArray = primeNumbers(maxNum);
			foreach (int element in intArray)
			{
				Console.WriteLine(element);
			}
		}
		catch (ArgumentOutOfRangeException e)
		{
      // This prints: "maxLimit must be > 1 \n Parameter name: maxLimit"
			Console.WriteLine(e.Message);
		}
	}
}
