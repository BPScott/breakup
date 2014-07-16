PATH  := node_modules/.bin:$(PATH)
SHELL := /bin/bash

source_files    := $(wildcard stylesheets/*.scss)
test_files      := $(wildcard test/*.scss)

expected_output_folder    := test/expected
libsass_output_folder     := build/libsass
rubysass_output_folder    := build/rubysass

libsass_output_files      := $(test_files:%.scss=build/libsass/%.css)
rubysass_output_files     := $(test_files:%.scss=build/rubysass/%.css)


.PHONY: all clean test

all: test

build/libsass/test/%.css: test/%.scss
	mkdir -p build/libsass/test
	node-sass $< $@

build/rubysass/test/%.css: test/%.scss
	mkdir -p build/rubysass/test
	sass $< $@


test: $(source_files) $(libsass_output_files) $(rubysass_output_files)
	diff -u --ignore-blank-lines $(expected_output_folder) $(rubysass_output_folder)/test
	diff -u --ignore-blank-lines $(expected_output_folder) $(libsass_output_folder)/test

clean:
	rm -rf build
