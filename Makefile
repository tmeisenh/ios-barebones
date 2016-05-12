APP          = JustTheTip
PROJECT      = JustTheTip
WORKSPACE    = JustTheTip
SCHEME			 = JustTheTip

PROJECT_ROOT = $(shell pwd)
OUTPUT_DIR = "$(PROJECT_ROOT)/build"

CONFIG       ?= Debug
DESTINATION  ?= "'platform=iOS Simulator,name=iPad 2'"
CODE_SIGN_IDENTITY ?= "code signing identity that is exactly what xcode displays - escape the parens"
PROVISIONING_PROFILE ?= "full path to provisioning profile file"


.PHONY: clean
default: test

rmderiveddata:
	@echo "Cleaned derived data."

clean: rmderiveddata
	@xcodebuild -sdk iphoneos -workspace "$(WORKSPACE).xcworkspace" -scheme "$(SCHEME)"  CONFIGURATION_BUILD_DIR="$(OUTPUT_DIR)" clean | xcpretty -c
	@rm -rf ~/Library/Developer/Xcode/DerivedData
	@rm -rf "$(OUTPUT_DIR)"

build: clean
	@xcodebuild -workspace "$(WORKSPACE).xcworkspace" -scheme "$(SCHEME)" -configuration "$(CONFIG)" CONFIGURATION_BUILD_DIR="$(OUTPUT_DIR)" build | xcpretty -c

test: build
	@xcodebuild -workspace "$(WORKSPACE).xcworkspace" -scheme "$(SCHEME)" -configuration "$(CONFIG)" -destination "${DESTINATION}" test | xcpretty -c -r junit

sign:
	@xcrun -sdk iphoneos PackageApplication -v "$(OUTPUT_DIR)/$(APP).app" -o "$(OUTPUT_DIR)/$(APP).ipa" --sign $(CODE_SIGN_IDENTITY)  --embed $(PROVISIONING_PROFILE)
