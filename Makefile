SOURCEDIR := src
SOURCES   := $(shell find $(SOURCEDIR) -name '*.lua')

picotron-utilities.p64.png: $(SOURCES)
	prt cp -f /projects/picotron-utilities/src /projects/picotron-utilities/picotron-utilities.p64.png
