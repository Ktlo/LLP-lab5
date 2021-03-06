# Поменяй эту переменную на название своей программы
export NAME:=cheburashka
# Так как многие пользуются Windows то переменная ниже
# будет содержать расширение испольняемых файлов Windows,
# которое можно убрать, если пользуешься MacOS или Linux.
# Просто закоментируй, если не нужно.
EXE:=.exe
#--------------------
# Экспортирую переменную TESTS, чтобы другие Makefile'ы, которые используют вызывает этот, могли получить к ней доступ
export TESTS
# Добавляю флаги, которые были указаны в задании к лабораторной, а также путь до заголовков библиотеки
export CFLAGS+= -Wall -std=c11 -pedantic -Wextra -I../include
# Подключить библиотеку с математикой, так как она скорее всего может пригодиться
export LDLIBS:=-lm
# Если переменная PREFIX не указана, то записать в неё стандартный путь /usr/local
PREFIX:=${or $(PREFIX),$(PREFIX),/usr/local}
# Сохранить список заголовков библиотеки в переменную ниже
includes=${wildcard include/*.h}

# Если указана отладочная среда, то компилиировать с отладочной оинформацией без оптимизаций
ifdef DEBUG
  CFLAGS+= -g -DDEBUG
else
  CFLAGS+= -O3 -DNDEBUG
endif

# Цель, помеченная как .PHONY не пытается найти соответствующий файл цели,
# поэтому выполняется каждый раз при вызове через make
.PHONY: build
# Самая первая цель выполняется без указания имени при вызове make
# Эта цель просто вызывает make в папке src
build:
	$(MAKE) -C src

.PHONY: example
# Эта цель вызывает make в папке src с указанием имени программы, которую она хочет получить на выходе
# Затем копирует готорый файл в корневую папку проекта для удобства
example:
	$(MAKE) -C src $(NAME)
	cp src/$(NAME) $(NAME)$(EXE)

.PHONY: test
# Эта цель выполняет тесты, для тестов необходимо, чтобы библиотека была собрана, что и указано в зависимостях цели
test: build
	$(MAKE) -C test

.PHONY: install
# Установка библиотеки в подпапки указанные в переменной PREFIX.
# После установки можно создать новый проект в другом месте и использовать эту библиотеку из него.
# В зависимостях цели указано, что библиотека должна быть построена сперва
install: build
	mkdir -p "$(PREFIX)/lib"
	mkdir -p "$(PREFIX)/include"
	cp src/lib$(NAME).a "$(PREFIX)/lib"
	cp $(includes) "$(PREFIX)/include"

.PHONY: uninstall
# Удаление тех файлов, которые также присутствуют в include из системы, а также удаление файла библиотеки
uninstall:
	$(RM) "$(PREFIX)/lib/lib$(NAME).a"
	$(RM) ${foreach header,$(includes),"$(PREFIX)/$(header)"}

.PHONY: clean
# Цель, которая удаляет все файлы, которые были сгенерированы компилятором и Makefile'ом
# Эта цель вызывает подобные цели в Makefile'ах в test и src
clean:
	$(MAKE) -C src clean
	$(MAKE) -C test clean
	$(RM) $(NAME)$(EXE)
