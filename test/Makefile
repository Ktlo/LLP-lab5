# Сохранить все исходники с тестами в эту переменную
src = ${wildcard *.c}
# Получить название исполняемых файлов тестов для каждого исходника
DEFAULT_TEST:= ${src:.c=.test}
# Если указана переменная TESTS, то забить на результаты в переменной ваше и использовать тесты в TESTS
test:=${or ${TESTS},${TESTS},${DEFAULT_TEST}}

# Основная цель, считается выполенной, если выполнены все её зависимости,
# где и перечислены все файлы с тестами
test: $(test)

# Шаблонный рецепт, получающий исполняемый файл с тестом из его исходника
# Этот рецепт также выполняет тест и... сразу удаляет его.
# Можно убрать нижнюю строчку этого рецепта про удаление, если тебе это кажется нелогичным.
# В таком случае тест будет выполнятся только тогда, когда произовли изменения в библиотеке
%.test: %.c ../src/lib${NAME}.a
	$(CC) $(CFLAGS) -DTEST -I../src $< -L../src -l$(NAME) -o $@
	$(GDB) ./$@
	@$(RM) $@

.PHONY: clean
# Удаление всех файлов с тестами, если они тут присутствуют по каким-то причинам.
# Вызывается из главного Makefile проекта из цели clean
clean:
	$(RM) $(DEFAULT_TEST)
