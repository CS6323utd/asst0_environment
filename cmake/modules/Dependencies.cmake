################################################################################
# CMake download helpers
################################################################################

# download external dependencies
include(DownloadExternal)

################################################################################
# Required dependencies
################################################################################

# NanoGUI & GLFW
if (NOT TARGET nanogui)
	# Disable building extras we won't need (pure C++ project)
	set(NANOGUI_BUILD_EXAMPLE OFF CACHE BOOL " " FORCE)
	set(NANOGUI_BUILD_PYTHON  OFF CACHE BOOL " " FORCE)
	set(NANOGUI_INSTALL       OFF CACHE BOOL " " FORCE)
	set(NANOGUI_BUILD_SHARED  OFF  CACHE BOOL " " FORCE)

	application_download_nanogui()
	add_subdirectory(${APPLICATION_EXTERNAL}/nanogui)

	include_directories(
	    ${APPLICATION_EXTERNAL}/nanogui/include
	    ${APPLICATION_EXTERNAL}/nanogui/ext/eigen
	    ${APPLICATION_EXTERNAL}/nanogui/ext/nanovg/src
	    ${APPLICATION_EXTERNAL}/nanogui/ext/glfw
	)
	
	set(GLFW_INCLUDE_DIRS ${APPLICATION_EXTERNAL}/nanogui/ext/glfw/include)
	if (APPLE)
	    # static lib, somehow not happy with dynamic lib
	    set(GLFW_LIBRARIES ${CMAKE_BINARY_DIR}/extern/nanogui/ext_build/glfw/src/libglfw3.a)
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

endif()
