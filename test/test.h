#ifdef _TEST_H
#	error "test.h file was included 2 times. This is not an expected behaviour in modular tests."
#endif
#define _TEST_H

#ifndef TEST_EPS
#	define TEST_EPS 1e-14
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int test_counter = 0;

#define TEST_ASSERTION_FAILED(val_type) \
		fprintf(stderr, "assertion error:%s:%d: \"" val_type "\" (%s) expected, got \"" val_type "\" (%s)\n", \
			file, line, a, expected, b, actual); \
		abort();

void _assert_equals_int(long long a, long long b, const char *file, int line, const char *expected, const char *actual) {
	if (a != b) {
		TEST_ASSERTION_FAILED("%lld")
	}
	test_counter++;
}

void _assert_equals_str(const char * a, const char * b, const char *file, int line, const char *expected, const char *actual) {
	if (strcmp(a, b)) {
		TEST_ASSERTION_FAILED("%s")
	}
	test_counter++;
}

void _assert_equals_float(long double a, long double b, const char *file, int line, const char *expected, const char *actual) {
	a -= b;
	if (a < .0)
		a = -a;
	if (a >= TEST_EPS) {
		TEST_ASSERTION_FAILED("%Lg")
	}
	test_counter++;
}

void _assert_equals_ptr(void * a, void * b, const char *file, int line, const char *expected, const char *actual) {
	if (a != b) {
		TEST_ASSERTION_FAILED("%p")
	}
	test_counter++;
}

#define assert_equals_int(expect, actual) \
		_assert_equals_int((expect), (actual), __FILE__ , __LINE__, #expect , #actual)

#define assert_equals_str(expect, actual) \
		_assert_equals_str((expect), (actual), __FILE__ , __LINE__, #expect , #actual)

#define assert_equals_float(expect, actual) \
		_assert_equals_float((expect), (actual), __FILE__ , __LINE__, #expect , #actual)

#define assert_equals_ptr(expect, actual) \
		_assert_equals_ptr((expect), (actual), __FILE__ , __LINE__, #expect , #actual)

#undef TEST_ASSERTION_FAILED

void test();

int main() {
	test();
	printf("Success! %d assertions passed!\n", test_counter);
	return 0;
}
