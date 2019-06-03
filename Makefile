#CFLAGS	= -g
CFLAGS	= 
#CC	= cc -framework Cocoa -framework CoreImage -fobjc-arc
LDFLAGS	= -framework Cocoa -framework CoreImage -framework Vision
CC	= cc -fobjc-arc
PROGS	= brr

.PHONY:	clean all

all:	$(PROGS)

clean:
	rm -f $(PROGS)

