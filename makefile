NDK_PATH?=/opt/android/ndk/android-ndk-r8d
SDK_PATH?=/opt/android/sdk/android-sdk-linux

PATH:=$(SDK_PATH)/tools:$(NDK_PATH):$(PATH)

ADB?=adb
# To choose a particular target either set the environment variable ANDROID_SERIAL
# or include DEVICE= on the command line
ifneq ($(DEVICE),)
  ADB_DEVICE=-s $(DEVICE)
endif

all: ndk sdk

sdk: build.xml
	ant debug

ndk:
	ndk-build

build.xml update-project:
	android update project --path . --target 11

install:
	$(ADB) $(ADB_DEVICE) install -r bin/test-debug.apk

run:
	$(ADB) $(ADB_DEVICE) shell am start -S -W com.test.test/com.test.test.test

logcat:
	$(ADB) $(ADB_TARGET) logcat -s 'test:v' 'AKIM:v'

dis: ndk
	`ndk-which objdump` -dr libs/armeabi-v7a/libtest.so > libtest.s

clean:
	rm -rf bin gen libs obj ant.properties build.xml proguard-project.txt project.properties local.properties libtest.s

APPNAME=test
ifeq ($(APPNAME),$(join sk,el))
clone:
	@if [ -z "$(CLONEDIR)" ] ; then echo CLONEDIR not set; exit 1; fi
	@if [ -e ../$(CLONEDIR) ]; then echo ../$(CLONEDIR) exists; exit 1; fi
	@echo "Cloning to ../$(CLONEDIR)"
	@mkdir ../$(CLONEDIR)
	@cp -rp . ../$(CLONEDIR)
	@find ../$(CLONEDIR) -type f | xargs sed -i -e 's/test/$(CLONEDIR)/g'
	@mv ../$(CLONEDIR)/src/com/test/test ../$(CLONEDIR)/src/com/test/$(CLONEDIR)
	@mv ../$(CLONEDIR)/src/com/test/$(CLONEDIR)/test.java ../$(CLONEDIR)/src/com/test/$(CLONEDIR)/$(CLONEDIR).java
	@mv ../$(CLONEDIR)/jni/test.c ../$(CLONEDIR)/jni/$(CLONEDIR).c
	@rm ../$(CLONEDIR)/README
	@echo "Sucessfully cloned to ../$(CLONEDIR)"
endif
