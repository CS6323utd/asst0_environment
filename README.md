# UTD CS6323 Compute Animation and Gaming

## Getting started
We will be distributing assignments with git. You can find the repository for this assignment at https://github.com/CS6323utd/asst0_environment. If you are unfamiliar with git, here is what you need to do to get the starter code:
```
$ git clone https://github.com/CS6323utd/asst0_environment.git
```
This will create an asst0_environment folder with all the source files.


## Build Instructions

In order to ease the process of running on different platforms, we will be using CMake for our assignments. You will need a CMake installation of version 3.5+ to build the code for this assignment. It should also be relatively easy to build the assignment and work locally on your OSX. Building on Linux is still working in process. Building on Windows is currently not supported, please refers to the old tuitorial.

If you are working on OS X and do not have CMake installed, we recommend installing it through [**Homebrew**](https://brew.sh/):
```
$ brew install cmake
```

### Build

To build your code for this assignment:
```
$ cd asst0_environment && mkdir build && cd build
$ cmake ..
$ make
```
These steps (1) create an out-of-source build directory, (2) configure the project using CMake, and (3) compile the project. If all goes well, you should see an executable app in the build directory. As you work, simply typing ```make``` in the build directory will recompile the project.

### Run

When you have successfully built your code, you will get an executable named **helloworld**. The helloworld executable do not take any argument. 

To run your executable file:
```
# under build folder
$ ./helloworld
```

When you first run the application, you will see a colored triangle on GUI.

<img src="https://github.com/CS6323utd/asst0_environment/blob/master/demo/triangle.png" width="300" height="300">

## FAQ / Dependencies / Troubleshooting

There are several dependencies we need to rely on, but for most of them you do not need to do anything, we've configured all of them through CMake. This section is just for you to be aware of these dependencies. If you have any issue during building process, please double check following dependencies before coming to TA's office hour.


#### 1. C++11 and OpenGL

You **DO NOT** need XCode for this assignment, although **Command Line Tools** is required.
These two should already setup in MacOS by default. You can verify by running:
```
# shows gcc version
$ gcc -v 

# shows "/Library/Developer/CommandLineTools"
$ xcode-select -p

# if swith from xcode to CLT
$ sudo xcode-select -s /Library/Developer/CommandLineTools

# if not installed, then run
$ xcode-select --install
```

#### 2. GLEW

We provide GLEW in our library (under ``deps`` folder), therefore, you **DO NOT** need to do anything. 

However, some might encounter follwing issue during while running  ```make```:
```
ld: library not found for -lglew
```
and one possible solution (from StackOverlow [post](https://stackoverflow.com/questions/26430432/ld-library-not-found/26431115#26431115)), add following line to file ```~/.bash_profile```:
```
# double check your glew location
# ATTENTION: version number might be different!!!!
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/Cellar/glew/2.1.0_1/lib/"
```
then run source to execute the change:
```
source ~/.bash_profile
```

If you want to use system GLEW, you can run following command to install GLEW then update CMakeLists.txt ON YOUR OWN.
```
######## OPTIONAL ######## 
$ brew install glew
# remember to update CMakeLists.txt
######## OPTIONAL ######## 
```

#### 3. NanoGUI

We setup these dependencies in our cmake/*.cmake files, therefore, you **DO NOT** need to do anything about it.


#### 4. GLFW

We will use the GLFW provided in NanoGUI, therefore, you **DO NOT** need to do anything. 

However, If you want to use system GLFW, you can run following command to install GLFW then update CMakeLists.txt ON YOUR OWN.
```
######## OPTIONAL ######## 
$ brew install glfw3
# remember to update CMakeLists.txt
######## OPTIONAL ######## 
```


## Acknowledge

This repo also use **DownloadProject** (https://github.com/Crascit/DownloadProject) for downloading and configuring NanoGUI (including GLFW). 

