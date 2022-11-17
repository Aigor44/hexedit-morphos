# Makefile for hexedit

PRODUCT = hexedit
VERSION = 1.6

SHELL = /bin/sh

CC = gcc
CFLAGS = -g -O2 -I/work/opt/ncursesw/include/ncursesw -I/work/opt/ncursesw/include
CPPFLAGS = 

LDFLAGS = 
LIBS = -L/work/opt/ncursesw/lib -lncursesw
DEFS = -DHAVE_CONFIG_H
INSTALL = /bin/install -c

# Installation directories
prefix = /work/opt/hexedit
datarootdir = ${prefix}/share
exec_prefix = ${prefix}
mandir = ${datarootdir}/man
bindir = ${exec_prefix}/bin

INCL = hexedit.h
SRCS = hexedit.c display.c mark.c page.c file.c interact.c misc.c search.c
OBJS = $(SRCS:.c=.o)

.SUFFIXES: .c .o

.c.o:
	$(CC) $(DEFS) $(CFLAGS) $(CPPFLAGS) -c $<

all: $(PRODUCT)

$(PRODUCT): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

clean:
	rm -rf *~ *.o core *.cache config.status config.log $(PRODUCT) $(PRODUCT).1

distclean: clean
	rm -f Makefile config.h Makefile-build

install: $(PRODUCT)
	$(INSTALL) -d -m 755 $(DESTDIR)$(bindir)
	$(INSTALL) -m 755 $(PRODUCT) $(DESTDIR)$(bindir)
	$(INSTALL) -d -m 755 $(DESTDIR)$(mandir)/man1
	$(INSTALL) -m 644 $(PRODUCT).1 $(DESTDIR)$(mandir)/man1
