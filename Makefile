OBJS=src/algorithm.o src/function.o src/ilp.o

CC=g++
LDFLAGS=-L/home/metaphor/latest/gurobi563/linux64/lib/ -lpython2.7 -lsqlite3
CFLAGS=-I/usr/include/python2.7 -I/home/metaphor/oct-2014-latest/gurobi563/linux64/include/

ifneq ($(shell grep -E '^\#define USE_GUROBI' src/defs.h),)
LDFLAGS+=-lgurobi_c++ -lgurobi56 -lpthread
endif

ifneq ($(shell grep -E '^\#define USE_LOCALSOLVER' src/defs.h),)
CFLAGS+=-I/opt/localsolver_2_1/include
LDFLAGS+=-llocalsolver
endif

ifneq ($(shell grep -E '^\#define USE_LPSOLVE' src/defs.h),)
LDFLAGS+=-llpsolve55
endif

%.o: %.cpp
	$(CC) $(CFLAGS) $(OPTIONS) -c $< -o $@

all: $(OBJS)
	mkdir -p ./bin
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) $(OPTIONS) -o ./bin/henry
