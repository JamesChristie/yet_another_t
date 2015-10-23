NAME=yet_another_t

SOURCEDIR=src
UTILDIR=$(SOURCEDIR)/util
TESTDIR=test
TESTUTILDIR=$(TESTDIR)/util
BUILDDIR=build
INCLUDEDIR=include
EXECUTABLE=yat
TESTEXECUTABLE=test_runner

FORTRANC=`which gfortran`
BASECFLAGS=-Wall -Wextra -pedantic -fcheck=bounds -Wuninitialized -g \
	   -Wno-unused-parameter -cpp -O
INCLUDEFLAGS=-I $(BUILDDIR)
CFLAGS=$(BASECFLAGS) $(INCLUDEFLAGS)

SOURCES := $(wildcard $(SOURCEDIR)/*.f90)
UTILITIES := $(wildcard $(UTILDIR)/*.f90)
TESTS := $(wildcard $(TESTDIR)/*.f90)
TESTUTILITIES := $(wildcard $(TESTUTILDIR)/*.f90)

UTILOBJECTS := $(patsubst $(UTILDIR)/%.f90, $(BUILDDIR)/%.o, $(UTILITIES))
SOURCEOBJECTS := $(patsubst $(SOURCEDIR)/%.f90, $(BUILDDIR)/%.o, $(SOURCES))
TESTOBJS := $(patsubst $(TESTDIR)/%.f90, $(BUILDDIR)/%.o, $(TESTS))
TESTUTILOBJS := $(patsubst $(TESTUTILDIR)/%.f90, $(BUILDDIR)/%.o, $(TESTUTILITIES))

all: build_dir final

build_dir:
	mkdir -p build

test: build_dir clean build_modules test_prep build_test

test_prep:
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $(BUILDDIR)/fruit.o $(INCLUDEDIR)/fruit.f90

build_test: $(TESTOBJS) $(TESTUTILOBJS)
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $(BUILDDIR)/test_runner.o test_runner.f90
	$(FORTRANC) $(CFLAGS) -o $(BUILDDIR)/$(TESTEXECUTABLE) \
	  $(BUILDDIR)/test_runner.o $(wildcard $(BUILDDIR)/*.o)
	rm $(BUILDDIR)/*.o
	rm $(BUILDDIR)/*.mod
	./build/$(TESTEXECUTABLE)

final: build_dir clean build_modules
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $(BUILDDIR)/$(NAME).o $(NAME).f90
	$(FORTRANC) $(CFLAGS) -o $(BUILDDIR)/$(EXECUTABLE) \
	  $(BUILDDIR)/$(NAME).o $(wildcard $(BUILDDIR)/*.o)
	rm $(BUILDDIR)/*.o
	rm $(BUILDDIR)/*.mod

build_modules: $(UTILOBJECTS) $(SOURCEOBJECTS)

$(BUILDDIR)/%.o: $(TESTDIR)/%.f90
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $@ $^

$(BUILDDIR)/%.o: $(TESTUTILDIR)/%.f90
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $@ $^

$(BUILDDIR)/%.o: $(SOURCEDIR)/%.f90
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $@ $^

$(BUILDDIR)/%.o: $(UTILDIR)/%.f90
	$(FORTRANC) $(CFLAGS) -c -J $(BUILDDIR) -o $@ $^

clean:
	rm -rf build/*
