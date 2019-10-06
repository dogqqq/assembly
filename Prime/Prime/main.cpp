#include <stdio.h>
#include <string>
#include <strstream>
using namespace std;

extern "C" void asmMain();
extern "C" int isPrime(int n);

int isPrime(int n) {
	for (int i = 2; i <= sqrt(n); i++) {
		if (n % i == 0) {
			return 0;
		}
	}
	return 1;
}


int main()
{
	asmMain();
	return 0;
}