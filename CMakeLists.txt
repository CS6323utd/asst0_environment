cmake_minimum_required(VERSION 2.8)
project(helloworld)

#-------------------------------------------------------------------------------
# Build options
#-------------------------------------------------------------------------------
option(BUILD_LIBCMU462 "Build with libCMU462"         ON)
option(BUILD_DEBUG     "Build with debug settings"    OFF)
option(BUILD_DOCS      "Build documentation"          OFF)


#-------------------------------------------------------------------------------
# Settings
#-------------------------------------------------------------------------------
# Add modules
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/modules/")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(APPLICATION_EXTERNAL "${CMAKE_CURRENT_SOURCE_DIR}/extern")

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  set(CMAKE_MACOSX_RPATH 1)
endif()


#-------------------------------------------------------------------------------
# Platform-specific settings
#-------------------------------------------------------------------------------

###################
# Building on OSX #
###################
if(APPLE)

  # OSX Framework dependencies
  if(NOT BUILD_LIBCMU462)
    include_directories( "/System/Library/Frameworks" )
    find_library (COCOA_LIBRARIES Cocoa)
    find_library (IOKIT_LIBRARIES IOkit)
    find_library (COREVIDEO_LIBRARIES CoreVideo)
  endif()

  # Clang configuration
  if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")

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

endif(APPLE)

##################
# Build on Linux #
##################
set(LINUX UNIX AND NOT APPLE)
if(LINUX)

  # GCC only
  if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")

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
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MD")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MD")

    if(BUILD_DEBUG)
        set(CMAKE_BUILD_TYPE Debug)
    else(BUILD_DEBUG)
    endif(BUILD_DEBUG)

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${MSVC_CXX_FLAGS}")
    add_definitions(-D_USE_MATH_DEFINES)

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
# Find dependencies
#-------------------------------------------------------------------------------

# OpenGL
find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)

##### hardcoded opengl settings
### please comment above two find_package and uncomment following sets if you see errors like 
### "could NOT find OpenGL (missing: OPENGL_INCLUDE_DIR)"
# set( OPENGL_INCLUDE_DIRS 
#     "/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/System/Library/Frameworks/OpenGL.framework/Headers"
# )
# set( GLUT_INCLUDE_DIRS 
#     "/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/System/Library/Frameworks/GLUT.framework/Headers"
# )
# set( OPENGL_gl_LIBRARY 
#     "/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib"
# )
# set( OPENGL_glu_LIBRARY 
#     "/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGLU.dylib"
# )

## not require so far
find_package(Threads REQUIRED)
if (NOT WIN32)
  find_package(Freetype REQUIRED)
endif ()


###### NanoGUI
# Disable building extras we won't need (pure C++ project)
set(NANOGUI_BUILD_EXAMPLE OFF CACHE BOOL " " FORCE)
set(NANOGUI_BUILD_PYTHON  OFF CACHE BOOL " " FORCE)
set(NANOGUI_INSTALL       OFF CACHE BOOL " " FORCE)
set(NANOGUI_BUILD_SHARED  OFF  CACHE BOOL " " FORCE)

# install nanogui and build
include(Dependencies)
include_directories(
    ${APPLICATION_EXTERNAL}/nanogui/include
    ${APPLICATION_EXTERNAL}/nanogui/ext/eigen
    ${APPLICATION_EXTERNAL}/nanogui/ext/nanovg/src
    ${APPLICATION_EXTERNAL}/nanogui/ext/glfw
)

# NanoGUI merges the glfw objects into the library being built, 
# you can actually just specify nanogui as the glfw dependency directly.
set(GLFW_FOUND ON)
set(GLFW_INCLUDE_DIRS ${APPLICATION_EXTERNAL}/nanogui/ext/glfw/include)
if (APPLE)
    # static lib, somehow not happy with dynamic lib
    set(GLFW_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/ext_build/glfw/src/libglfw3.a)
    # set(GLFW_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/ext_build/glfw/src/libglfw.dylib)
    #### if you want to use system GLFW, uncomment following two lines
    # set(GLFW_INCLUDE_DIRS "/usr/local/include/")
    # set(GLFW_LIBRARIES "/usr/local/lib/libglfw.dylib")
endif(APPLE)
if(LINUX)
    set(NANOGUI_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/libnanogui.so)
    set(GLFW3_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/ext_build/glfw/src/libglfw.so)
    #### if you want to use system GLFW, uncomment following two lines
    # set(GLFW_INCLUDE_DIRS /usr/include)
    # set(GLFW3_LIBRARIES /usr/lib/x86_64-linux-gnu/libglfw.so)
endif(LINUX)


# CMU462
if(BUILD_LIBCMU462)
  add_subdirectory(CMU462)
  include_directories(CMU462/include)
  include_directories(CMU462/include/CMU462)
else(BUILD_LIBCMU462)
  find_package(CMU462 REQUIRED)
  find_package(GLEW REQUIRED)
  find_package(GLFW REQUIRED)
endif(BUILD_LIBCMU462)

#-------------------------------------------------------------------------------
# Add subdirectories
#-------------------------------------------------------------------------------
add_subdirectory(src)

# build documentation
if(BUILD_DOCS)
  find_package(DOXYGEN)
  if(DOXYGEN_FOUND AND BUILD_DOCS)
    add_subdirectory(docs)
  endif()
endif()

# Install settings
set(CMAKE_INSTALL_PREFIX "${helloworld_SOURCE_DIR}/")
