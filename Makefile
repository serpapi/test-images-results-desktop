# Run images result test
#

test_cmd=`grep script .travis.yml  | cut -d':' -f2`

.EXPORT_ALL_VARIABLES:
SERPAPI_MODE=dev

all: test

# run unit test
test:
	$(test_cmd)

# install dependency
dep:
	bundle install
