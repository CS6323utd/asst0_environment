cmake_minimum_required(VERSION 2.8)

# source
set(APPLICATION_SOURCE
    main.cpp
)

# header
set(APPLICATION_HEADER
    shader.h
)

#-------------------------------------------------------------------------------
# Set include directories
#-------------------------------------------------------------------------------
include_directories(
  ${GLEW_INCLUDE_DIRS}
  ${GLFW3_INCLUDE_DIRS}
)

#-------------------------------------------------------------------------------
# Add executable
#-------------------------------------------------------------------------------
add_executable( hello
    ${APPLICATION_SOURCE}
    ${APPLICATION_HEADER}
)


target_link_libraries(hello
  GLEW ${GLEW_LIBRARIES}
  glfw ${GLFW3_LIBRARIES}
  ${OPENGL_opengl_LIBRARY}
)

message(STATUS "Found OPENGL in ${OPENGL_INCLUDE_DIR}, OPENGL_LIBRARIES ${OPENGL_opengl_LIBRARY}")
message(STATUS "Found GLEW in ${GLEW_INCLUDE_DIRS}, GLEW_LIBRARIES ${GLEW_LIBRARIES}")
message(STATUS "Found GLFW in ${GLFW3_INCLUDE_DIRS}, GLFW3_LIBRARIES ${GLFW3_LIBRARIES}")


add_dependencies(hello nanogui glfw glfw_objects) # NanoGUI builds these


#-------------------------------------------------------------------------------
# Platform-specific configurations for target
#-------------------------------------------------------------------------------
if(APPLE)
  set_property( TARGET hello APPEND_STRING PROPERTY COMPILE_FLAGS
                "-Wno-deprecated-declarations -Wno-c++11-extensions")
endif(APPLE)

# Put executable in build directory root
set(EXECUTABLE_OUTPUT_PATH ..)