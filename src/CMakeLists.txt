cmake_minimum_required(VERSION 2.8)

#-------------------------------------------------------------------------------
# Set include directories
#-------------------------------------------------------------------------------
include_directories(
    ${FREETYPE_INCLUDE_DIRS}
    ${CMU462_INCLUDE_DIRS}
    ${GLEW_INCLUDE_DIRS}
    ${GLFW_INCLUDE_DIRS}
)

if (WIN32)
    include_directories(dirent)
endif(WIN32)

#-------------------------------------------------------------------------------
# Set link directories
#-------------------------------------------------------------------------------
link_directories(
    ${FREETYPE_LIBRARY_DIRS}
    ${CMU462_LIBRARY_DIRS}
    ${GLEW_LIBRARY_DIRS}
    ${GLFW_LIBRARY_DIRS}
)

# Set helloworld source
set(CMU462_helloworld_SOURCE
    main.cpp
)

if (WIN32)
    list(APPEND CMU462_helloworld_SOURCE dirent/dirent.c)
endif(WIN32)

# Set helloworld header
set(CMU462_helloworld_HEADER
    shader.h
)

# Import hardware renderer
# option(helloworld_BUILD_HARDWARE_RENDERER  "Build hardware implementation"  ON)
# include(hardware/hardware.cmake)

# Import helloworld reference
# include(reference/reference.cmake)

#-------------------------------------------------------------------------------
# Add executable
#-------------------------------------------------------------------------------
add_executable( helloworld
    ${CMU462_helloworld_SOURCE}
    ${CMU462_helloworld_HEADER}
)

# Link helloworld executable (static link reference solution)
target_link_libraries( helloworld
    nanogui ${NANOGUI_EXTRA_LIBS}
    ${FREETYPE_LIBRARIES}
    ${OPENGL_LIBRARIES}
    CMU462 ${CMU462_LIBRARIES}
    glew ${GLEW_LIBRARIES}
    glfw ${GLFW_LIBRARIES}
)


if (APPLE) # Frameworks required on osx
  target_link_libraries(helloworld  
    ${COCOA_LIBRARIES}
    ${IOKIT_LIBRARIES}
    ${COREVIDEO_LIBRARIES}
  )
else(UNIX)  #LINUX
target_link_libraries( helloworld
    ${CMU462_LIBRARIES}
    ${GLEW_LIBRARIES}
    ${GLFW_LIBRARIES}
    ${FREETYPE_LIBRARIES}
    ${OPENGL_LIBRARIES}
    -fopenmp 
    -lXi 
    -lXxf86vm 
    -lXinerama 
    -lXcursor 
    -lXfixes 
    -lXrandr 
    -lXext 
    -lXrender 
    -lX11 
    -lpthread 
    -lxcb 
    -lXau
)
endif()

# Put executable in build directory root
set(EXECUTABLE_OUTPUT_PATH ..)

# Install to project root
install(TARGETS helloworld DESTINATION ${helloworld_SOURCE_DIR})

# Copy Freetype DLLs to the build directory
if(WIN32)
    foreach(FREETYPE_DLL ${FREETYPE_RUNTIMELIBS})
        add_custom_command(TARGET helloworld POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${FREETYPE_DLL}"
                $<TARGET_FILE_DIR:helloworld>)
    endforeach(FREETYPE_DLL)
endif(WIN32)