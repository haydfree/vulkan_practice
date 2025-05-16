TARGET   	:= vulkan

CMP      	:= clang
CINCS	 	:= -I.
LINCS    	:= -I.
DBFLAGS  	:= -g3 -O0 -DTESTING
STFLAGS   	:= -ansi -Wall -Wextra -Werror -Wpedantic -Wconversion -Wshadow -Wuninitialized -Wformat -Wimplicit-fallthrough -Wundef -Wmisleading-indentation -Wnull-dereference -Wduplicate-decl-specifier -Wredundant-decls 
CFLAGS   	:= ${CINCS} ${DBFLAGS} ${STFLAGS} 
LFLAGS   	:= ${LINCS} ${DBFLAGS} ${STFLAGS} 

SRCS		:= main.c
OBJS  		:= ${SRCS:.c=.o}

${TARGET}: ${OBJS}
	@${CMP} ${OBJS} ${LFLAGS} -o ${TARGET}

.c.o:
	@${CMP} ${CFLAGS} -c $< -o $@

clean:
	@rm -f ${OBJS} ${TARGET} *.core

run: ${TARGET}
	@./${TARGET}

all:
	@clear; ${MAKE} clean; ${MAKE}; ${MAKE} run;

commit:
	@git add .
	@git commit -m "AUTO COMMIT: `date +'%Y-%m-%d %H:%M:%S'`"
	@git push origin main

install: ${TARGET}
	@rm /usr/local/bin/${TARGET}
	@cp ${TARGET} /usr/local/bin/${TARGET}

MAKEFLAGS += --no-print-directory
.PHONY: clean run all commit install


