# UTD CS6323 Compute Animation and Gaming

## Getting started
We will be distributing assignments with git. You can find the repository for this assignment at https://github.com/CS6323utd/asst0_environment. If you are unfamiliar with git, here is what you need to do to get the starter code:
```
$ git clone https://github.com/CS6323utd/asst0_environment.git
```
This will create an asst0_environment folder with all the source files.


## Build Instructions

In order to ease the process of running on different platforms, we will be using CMake for our assignments. You will need a CMake installation of version 3.5+ to build the code for this assignment. It should also be relatively easy to build the assignment and work locally on your OSX. Building on Linux is still working in process. Building on Windows is currently not supported, please refers to the old tuitorial.


### Mac

If you are working on OS X and do not have CMake installed, we recommend installing it through [**Homebrew**](https://brew.sh/):
```
brew install cmake
```

#### Build

To build your code for this assignment:
```
$ cd asst0_environment && mkdir build && cd build
$ cmake ..
$ make
```
These steps (1) create an out-of-source build directory, (2) configure the project using CMake, and (3) compile the project. If all goes well, you should see an executable app in the build directory. As you work, simply typing ```make``` in the build directory will recompile the project.

#### Run

When you have successfully built your code, you will get an executable named **helloworld**. The helloworld executable do not take any argument. When you first run the application, you will see a colored triangle on GUI.

To run your executable file:
```
# under build folder
$ ./helloworld
```

#### Dependencies / Troubleshooting

There are several dependencies we need to rely on, but for most of them you do not need to do anything, we've configured all of them through CMake. This section is just for you to be aware of these dependencies. If you have any issue during building process, please double check following dependencies before coming to TA's office hour.


1. C++11 and OpenGL

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

2. GLEW

We provide GLEW in our library, therefore, you **DO NOT** need to do anything. 

However, If you want to use system GLEW, you can run following command to install GLEW then update CMakeLists.txt ON YOUR OWN.
```
######## OPTIONAL ######## 
$ brew install glew
# remember to update CMakeLists.txt
######## OPTIONAL ######## 
```

3. NanoGUI

We setup these dependencies in our cmake/*.cmake files, therefore, you **DO NOT** need to do anything about it.


4. GLFW

We will use the GLFW provided in NanoGUI, therefore, you **DO NOT** need to do anything. 

However, If you want to use system GLFW, you can run following command to install GLFW then update CMakeLists.txt ON YOUR OWN.
```
######## OPTIONAL ######## 
$ brew install glfw3
# remember to update CMakeLists.txt
######## OPTIONAL ######## 
```


### Linux (In progress, please do not follow)
```
######## OPTIONAL ######## 
$ sudo apt-get install libxinerama-dev
$ sudo apt-get install libxcursor-dev
$ sudo apt-get install libglew-dev libglfw3 libglfw3-dev libglm-dev pkg-config
######## OPTIONAL ######## 
```


## Acknowledge

This repo use the **CMU462 Library** (https://github.com/cmu462/Scotty3D/tree/master/CMU462) for configuring OpenGL/GLFW/GLEW.

This repo also use **DownloadProject** (https://github.com/Crascit/DownloadProject) for downloading and configuring NanoGUI. 

