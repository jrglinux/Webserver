#Default C compiler options.
CFLAGS	= -Wall -g
#C source files for the server.
SOURCES	= server.c module.c common.c main.c
#Corresponding object files.
OBJECTS	= $(SOURCES:.c=.o)
#Server module shared library files.
MODULES	= diskfree.so issue.so process.so time.so

.PHONY:	all clean

#Default target: build everything.
all:	server $(MODULES)

#Clean up build products.
clean:
	rm -f $(OBJECTS) $(MODULES) server

server:	$(OBJECTS)
	$(CC) $(CFLAGS) -Wl,-export -dynamic -o $@ $^ -ldl

$(OBJECTS):	server.h

$(MODULES):	\
%.so:	%.c server.h
	$(CC) $(CFLAGS) -fPIC -shared -o $@ $<
