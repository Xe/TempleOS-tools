U0 HelloWorld {
	MOV	RAX,'Hello, w'
	CALL	&PUT_CHARS
	MOV	RAX,'orld!\n'
	CALL	&PUT_CHARS
}

HelloWorld;
Uf("HelloWorld");
