NAME=yet_another_t

SOURCEDIR=src
TESTDIR=test
BUILDDIR=build
INCLUDEDIR=include
EXECUTABLE=$(NAME)
TESTEXECUTABLE=test_runner

FORTRANC=`which gfortran`
BASECFLAGS=-Wall -Wextra -pedantic -fcheck=bounds -Wuninitialized -g \
	   -Wno-unused-parameter -cpp -O
INCLUDEFLAGS=-I $(BUILDDIR)
CFLAGS=$(BASECFLAGS) $(INCLUDEFLAGS)

SOURCES := $(wildcard $(SOURCEDIR)/*.f90)
TESTS := $(wildcard $(TESTDIR)/*.f90)

SOURCEOBJECTS := $(patsubst $(SOURCEDIR)/%.f90, $(BUILDDIR)/%.o, $(SOURCES))
TESTOBJS := $(patsubst $(TESTDIR)/%.f90, $(BUILDDIR)/%.o, $(TESTS))

all: build_dir final

build_dir:
	mkdir -p build

test: build_dir clean build_modules test_prep build_test

test_prep:
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $(BUILDDIR)/fruit.o $(INCLUDEDIR)/fruit.f90

build_test: $(SOURCEOBJS) $(TESTOBJS)
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $(BUILDDIR)/test_runner.o test_runner.f90
	$(FORTRANC) $(CFLAGS) -o $(BUILDDIR)/$(TESTEXECUTABLE) \
          $(BUILDDIR)/test_runner.o $(wildcard $(BUILDDIR)/*.o)
	./build/$(TESTEXECUTABLE)

final: build_dir clean build_modules
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $(BUILDDIR)/$(NAME).o $(NAME).f90
	$(FORTRANC) $(CFLAGS) -o $(BUILDDIR)/$(EXECUTABLE) \
          $(BUILDDIR)/$(NAME).o $(wildcard $(BUILDDIR)/*.o)

build_modules: $(SOURCEOBJECTS)

$(BUILDDIR)/%.o: $(TESTDIR)/%.f90
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $@ $^

$(BUILDDIR)/%.o: $(SOURCEDIR)/%.f90
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $@ $^

clean:
	rm -rf build/*
