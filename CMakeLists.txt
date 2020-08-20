cmake_minimum_required(VERSION 3.5)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)


#-------------------------------------------------------------------------------
# Project name
#-------------------------------------------------------------------------------
project(helloworld)


#-------------------------------------------------------------------------------
# Settings
#-------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(APPLICATION_EXTERNAL "${CMAKE_CURRENT_SOURCE_DIR}/extern")


set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(SRC_LIB "${CMAKE_CURRENT_SOURCE_DIR}/lib")

file(GLOB SRCS "${SRC_DIR}/*.cpp","${SRC_DIR}/*.h")


#-------------------------------------------------------------------------------
# Platform-specific settings
#-------------------------------------------------------------------------------

###################
# Building on OSX #
###################
if(APPLE)

  # Clang only
  if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "CLANG")

    # OSX Framework dependencies
    if(NOT BUILD_LIBCMU462)
      include_directories( "/System/Library/Frameworks" )
      find_library (COCOA_LIBRARIES Cocoa)
      find_library (IOKIT_LIBRARIES IOkit)
      find_library (COREVIDEO_LIBRARIES CoreVideo)
    endif()

    # Clang configuration
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")

      set(CLANG_CXX_FLAGS "-std=c++11 -m64")

      if(BUILD_DEBUG)
        set(CMAKE_BUILD_TYPE Debug)
      else(BUILD_DEBUG)
        set(CLANG_CXX_FLAGS "${CLANG_CXX_FLAGS} -O3")
        set(CLANG_CXX_FLAGS "${CLANG_CXX_FLAGS} -funroll-loops")
        set(CLANG_CXX_FLAGS "${CLANG_CXX_FLAGS} -Wno-narrowing")
        set(CLANG_CXX_FLAGS "${CLANG_CXX_FLAGS} -Wno-deprecated-register")
      endif(BUILD_DEBUG)

      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CLANG_CXX_FLAGS}")

    endif()

    # GCC configuration
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")

      set(GCC_CXX_FLAGS "-std=gnu++11 -m64")

      if(BUILD_DEBUG)
        set(CMAKE_BUILD_TYPE Debug)
      else(BUILD_DEBUG)
        set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -O3")
        set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -fopenmp")
      endif(BUILD_DEBUG)

      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GCC_CXX_FLAGS}")

    endif()

  endif()

endif(APPLE)

##################
# Build on Linux #
##################
set(LINUX UNIX AND NOT APPLE)
if(LINUX)

  # GCC only
  if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")

    set(GCC_CXX_FLAGS "-std=gnu++11 -m64")

    # X11 Dependencies
    if(NOT BUILD_LIBCMU462)
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXi")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXxf86vm")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXinerama")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXcursor")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXfixes")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXrandr")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXext")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXrender")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lX11")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lpthread")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lxcb")
      set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -lXau")
    endif()

    # Debug configuration
    if(BUILD_DEBUG)
        set(CMAKE_BUILD_TYPE Debug)
    else(BUILD_DEBUG)
        set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -O3")
        set(GCC_CXX_FLAGS "${GCC_CXX_FLAGS} -fopenmp")
    endif(BUILD_DEBUG)

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GCC_CXX_FLAGS}")

  endif()

endif(LINUX)

####################
# Build on Windows #
####################
if(WIN32)

  if(MSVC)

    set(MSVC_CXX_FLAGS "-std=gnu++11")

    if(BUILD_DEBUG)
        set(CMAKE_BUILD_TYPE Debug)
    else(BUILD_DEBUG)
    endif(BUILD_DEBUG)

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${MSVC_CXX_FLAGS}")

  endif(MSVC)

  if(MINGW)

    set(MSVC_CXX_FLAGS "-std=gnu++11")

    if(BUILD_DEBUG)
        set(CMAKE_BUILD_TYPE Debug)
    else(BUILD_DEBUG)
    endif(BUILD_DEBUG)

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${MSVC_CXX_FLAGS}")

  endif(MINGW)

endif(WIN32)


#-------------------------------------------------------------------------------
# Find dependencies (3rd party libraries)
#-------------------------------------------------------------------------------

###### opengl
# find_package(OpenGL REQUIRED)
# find_package(GLUT REQUIRED)
set( OPENGL_INCLUDE_DIRS 
    "/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/System/Library/Frameworks/OpenGL.framework/Headers"
)
set( GLUT_INCLUDE_DIRS 
    "/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/System/Library/Frameworks/GLUT.framework/Headers"
)
set( OPENGL_gl_LIBRARY 
    "/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib"
)
set( OPENGL_glu_LIBRARY 
    "/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGLU.dylib"
)

###### glfw
#find_package(glfw3 REQUIRED)
#include_directories(${GLFW_INCLUDE_DIRS})

###### glm
# find_package(glm REQUIRED)

###### glad
# add_library(GLAD "${SRC_LIB}/glad.c")

###### glew
find_package(glew REQUIRED)
# set(GLEW_INCLUDE_DIRS "/usr/local/Cellar/glew/2.1.0_1/lib/libGLEW.2.1.0.dylib")


###### nanogui

# Disable building extras we won't need (pure C++ project)
set(NANOGUI_BUILD_EXAMPLE OFF CACHE BOOL " " FORCE)
set(NANOGUI_BUILD_PYTHON  OFF CACHE BOOL " " FORCE)
set(NANOGUI_INSTALL       OFF CACHE BOOL " " FORCE)

# install nanogui and add_subdirectory
include(Dependencies)

# For reliability of parallel build, make the NanoGUI targets dependencies
set_property(TARGET glfw glfw_objects nanogui PROPERTY FOLDER "dependencies")

# NanoGUI merges the glfw objects into the library being built, 
# you can actually just specify nanogui as the glfw dependency directly.
#set(GLFW3_FOUND ON)
#set(GLFW3_INCLUDE_DIRS /usr/include)
#set(GLFW3_LIBRARIES /usr/lib/x86_64-linux-gnu/libglfw.so)
#set(NANOGUI_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/libnanogui.so)
#link_directories( ${CMAKE_BINARY_DIR}/extern/nanogui/ )

if (APPLE)
    set(GLFW3_INCLUDE_DIRS ${APPLICATION_EXTERNAL}/nanogui/ext/glfw/include)
    # set(NANOGUI_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/libnanogui.dylib)
    set(GLFW3_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/ext_build/glfw/src/libglfw.dylib)
endif(APPLE)

if(LINUX)
    set(GLFW3_INCLUDE_DIRS ${APPLICATION_EXTERNAL}/nanogui/ext/glfw/include)
    set(NANOGUI_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/libnanogui.so)
    set(GLFW3_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/ext_build/glfw/src/libglfw.so)
endif(LINUX)

# nanogui should have glfw source
# if not, we need to find
if(NOT GLFW3_FOUND)
    find_package(GLFW3 REQUIRED)
endif()

include_directories(
    ${APPLICATION_EXTERNAL}/nanogui/include
    ${APPLICATION_EXTERNAL}/nanogui/ext/eigen
    ${APPLICATION_EXTERNAL}/nanogui/ext/nanovg/src
    ${APPLICATION_EXTERNAL}/nanogui/ext/glfw
)
include_directories(
    ${OPENGL_INCLUDE_DIRS}
    ${GLUT_INCLUDE_DIRS} 
    ${GLEW_INCLUDE_DIRS} 
    ${GLFW3_INCLUDE_DIRS}
)


#-------------------------------------------------------------------------------
# Build
#-------------------------------------------------------------------------------
add_executable(hello ${SRCS})

# NanoGUI builds these
add_dependencies(hello nanogui glfw) 

set( LIBS 
    ${LIBS} 
    nanogui 
    GL 
    GLEW 
    glfw 
    ${GLEW_LIBRARY}
    ${OPENGL_gl_LIBRARY} 
    ${OPENGL_glu_LIBRARY} 
    ${NANOGUI_EXTRA_LIBS}
)

message(STATUS "LIBS: ${LIBS}")

target_link_libraries( hello
    PUBLIC
        nanogui
        ${NANOGUI_EXTRA_LIBS}
    PRIVATE
        ${GLEW_LIBRARY}
        ${OPENGL_gl_LIBRARY} 
        ${OPENGL_glu_LIBRARY} 
)
