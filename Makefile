# Поменяй эту переменную на название своей программы
export NAME:=cheburashka
# Так как многие пользуются Windows то переменная ниже
# будет содержать расширение испольняемых файлов Windows,
# которое можно убрать, если пользуешься MacOS или Linux.
# Просто закоментируй, если не нужно.
EXE:=.exe
#--------------------
export TESTS
export CFLAGS:=-Wall -std=c11 -pedantic -Wextra -I../include $(CFLAGS)
export LDLIBS:=-lm
PREFIX:=${or $(PREFIX),$(PREFIX),/usr/local}
includes=${wildcard include/*.h}

ifdef DEBUG
  CFLAGS:=$(CFLAGS) -g -DDEBUG
else
  CFLAGS:=$(CFLAGS) -O3 -DNDEBUG
endif

.PHONY: build
build:
	$(MAKE) -C src

.PHONY: example
example:
	$(MAKE) -C src $(NAME)
	cp src/$(NAME) $(NAME)$(EXE)

.PHONY: test
test: build
	$(MAKE) -C test

.PHONY: install
install: build
	mkdir -p "$(PREFIX)/lib"
	mkdir -p "$(PREFIX)/include"
	cp src/lib$(NAME).a "$(PREFIX)/lib"
	cp $(includes) "$(PREFIX)/include"

.PHONY: uninstall
uninstall:
	$(RM) "$(PREFIX)/lib/lib$(NAME).a"
	$(RM) ${foreach header,$(includes),"$(PREFIX)/$(header)"}

.PHONY: clean
clean:
	$(MAKE) -C src clean
	$(MAKE) -C test clean
	$(RM) $(NAME)
