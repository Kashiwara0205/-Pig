unit:
	nim compile ./test/test.nim
	./test/test

update:
	nim -o:bin/reversi c src/main.nim

start:
	bin/reversi