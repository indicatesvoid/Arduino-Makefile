# A Makefile for Arduino Sketches
#####Modified to use a compiled C program for board reset (no dependencies) instead of a Perl script.

This is a very simple Makefile which knows how to build Arduino sketches. It defines the entire workflows for compiling code, flashing it to Arduino and even communicating through Serial monitor. You don't need to change anything in the Arduino sketches.

If you're using FreeBSD, Debian or Ubuntu, you can find this in the `arduino-mk` package.

## Usage

You can also find more [detailed instructions in this guide](http://hardwarefun.com/tutorials/compiling-arduino-sketches-using-makefile) or also checkout the sample makefiles inside the examples/ folder

Download a copy of this repo some where in your system.

On the Mac you might want to set:

    ARDUINO_DIR   = /Applications/Arduino.app/Contents/Resources/Java
    ARDMK_DIR     = /usr/local
    AVR_TOOLS_DIR = /usr

On Linux, you shouldn't need to set anything other than your board type and port:

    BOARD_TAG    = mega2560
    MONITOR_PORT = /dev/ttyACM0

- `BOARD_TAG` - Type of board, for a list see boards.txt or `make show_boards`
- `MONITOR_PORT` - The port where your Arduino is plugged in, usually `/dev/ttyACM0` or `/dev/ttyUSB0`
- `ARDUINO_DIR` - Path to Arduino installation
- `ARDMK_DIR`   - Path where the `*.mk` are present. If you installed the package, then it is usually `/usr/share/arduino`
- `AVR_TOOLS_DIR` - Path where the avr tools chain binaries are present. If you are going to use the binaries that came with Arduino installation, then you don't have to set it.

The Makefile also delegates resetting the board to a binary executable (currently only Mac-compatible)

## Including Libraries

For libraries that are built into the Arduino core, or placed inside the Arduino 'libraries' directory, you can specify space separated list of libraries that are needed for your sketch to the variable `ARDUINO_LIBS`.

`ARDUINO_LIBS = Wire SoftwareSerial`

The libraries will be searched in the following places in the following order.

- `/libraries` folder inside your sketchbook folder. Sketchbook folder will be auto detected from your Arduino preference file. You can also manually set it through `ARDUINO_SKETCHBOOK`.
- `/libraries` folder inside your Arduino folder, which is read from `ARDUINO_DIR`.

The libraries inside user folder will take precedence over libraries present in Arduino core folder.

The makefile can autodetect the libraries that are included from your sketch and can include them automatically. But it can't detect libraries that are included from other libraries. (see [issue #93](https://github.com/sudar/Arduino-Makefile/issues/93))

You can also set a user-defined path to other source files/libraries by setting the USER_LIB_PATH variable inside the child makefile:

`USER_LIB_PATH = libs`

This will crawl through the defined directory as well as all of its subdirectories, for example

`libs/Library01.h`
and
`libs/morelibs/Libary02.h`

Will both be compiled and linked.

## avrdude

To upload compiled files, `avrdude` is used. This Makefile tries to find `avrdude` and it's config (`avrdude.conf`) below `ARDUINO_DIR`. If you like to use the one installed on your system instead of the one which came with Arduino, you can try to set the variables `AVRDUDE` and `AVRDUDE_CONF`. On a typical Linux system these could be set to

      AVRDDUDE     = /usr/bin/avrdude
      AVRDUDE_CONF = /etc/avrdude.conf

## Colorgcc

It is possible to use [`colorgcc`](https://github.com/colorgcc/colorgcc) with this makefile. Check out [this comment](http://hardwarefun.com/tutorials/compiling-arduino-sketches-using-makefile#comment-1408) to find usage instructions.

## Versioning

The current version of the makefile is `1.2.0`. You can find the full history in the [HISTORY.md](HISTORY.md) file

This project adheres to Semantic [Versioning 2.0](http://semver.org/).

## License

This makefile and the related documentation and examples are free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

## Contribution

All contributions (even documentation) are welcome :) Open a pull request and I would be happy to merge them.
Also checkout the [contribution guide](CONTRIBUTING.md) for more details.

If you are looking for ideas to work on, then check out the following TODO items or the [issue tracker](https://github.com/sudar/Arduino-Makefile/issues/).

## Limitations / Know Issues / TODO's

- Doesn't work with Arduino 1.5.x yet. Follow [issue #45](https://github.com/sudar/Arduino-Makefile/issues/45) for progress.
- Since it doesn't do any pre processing like Arduino IDE, you have to declare all methods before you use them ([issue #59](https://github.com/sudar/Arduino-Makefile/issues/59))
- More than one .ino or .pde file is not supported yet ([issue #49](https://github.com/sudar/Arduino-Makefile/issues/49))
- When you compile for the first time, it builds all libs inside Arduino directory even if it is not needed. But while linking only the relevant files are linked. ([issue #29](https://github.com/sudar/Arduino-Makefile/issues/29)). Even Arduino IDE does the same thing though.

If you find an issue or have an idea for a feature then log them in the [issue tracker](https://github.com/sudar/Arduino-Makefile/issues/)

## Credits

This makefile was originally created by [Martin Oldfield](http://mjo.tc/atelier/2009/02/arduino-cli.html) and he maintained it till v0.10.2.
From May 2013, it is maintained by [Sudar](http://hardwarefun.com/tutorials/compiling-arduino-sketches-using-makefile)

## Similar works
- It's not a derivative of this, but Alan Burlison has written a [similar thing](http://bleaklow.com/2010/06/04/a_makefile_for_arduino_sketches.html).
- Alan's Makefile was used in a [Pragmatic Programmer's article](http://pragprog.com/magazines/2011-04/advanced-arduino-hacking).
- Rei Vilo wrote to tell me that he's using the Makefile ina Xcode 4 template called [embedXcode](http://embedxcode.weebly.com/). Apparently it supports many platforms and boards, including AVR-based Arduino, AVR-based Wiring, PIC32-based chipKIT, MSP430-based LaunchPad and ARM3-based Maple.
