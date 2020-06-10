SWIFT_BUILD_FLAGS=--configuration release

all: build

build:
	swift build $(SWIFT_BUILD_FLAGS)

clean:
	rm -f Package.resolved
	rm -rf .build

update:
	swift package update

xcode:
	swift package generate-xcodeproj