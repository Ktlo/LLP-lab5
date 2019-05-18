src = ${wildcard *.c}
dep = ${src:.c=.d}
CFLAGS:=$(CFLAGS) -DTEST -I../src
DEFAULT_TEST:= ${src:.c=.test}
test:=${or ${TESTS},${TESTS},${DEFAULT_TEST}}

test: $(test)

%.test: %.c
	$(CC) $(CFLAGS) $< -L../src -l$(NAME) -o $@
	$(GDB) ./$@
	@$(RM) ./$@

.PHONY: clean
clean:
	$(RM) $(DEFAULT_TEST)
