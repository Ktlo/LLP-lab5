src = ${wildcard *.c}
obj = ${filter-out main.o,${src:.c=.o}}
dep = ${src:.c=.d}

lib$(NAME).a: $(obj)
	$(AR) $(ARFLAGS) $@ $^

$(NAME): main.o lib$(NAME).a
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

-include $(dep)

%.d: %.c
	@$(CPP) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@

.PHONY: clean
clean:
	$(RM) lib$(NAME).a $(obj) $(dep) $(NAME) main.o
