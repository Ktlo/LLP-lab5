src = ${wildcard *.c}
dep = ${src:.c=.d}
DEFAULT_TEST:= ${src:.c=.test}
test:=${or ${TESTS},${TESTS},${DEFAULT_TEST}}

test: $(test)

%.test: %.c
	$(CC) $(CFLAGS) -DTEST -I../src $< -L../src -l$(NAME) -o $@
	$(GDB) ./$@
	@$(RM) $@

.PHONY: clean
clean:
	$(RM) $(DEFAULT_TEST)
