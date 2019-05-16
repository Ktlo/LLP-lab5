#include "test.h"
#include "hello_world.h"

void test() {
	assert_equals_str("Hello World!", foo());
	assert_equals_int(-1 + 1, 0);
}
