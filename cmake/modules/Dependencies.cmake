################################################################################
# CMake download helpers
################################################################################

# download external dependencies
include(DownloadExternal)

################################################################################
# Required dependencies
################################################################################

# nanogui
if (NOT TARGET nanogui)
	application_download_nanogui()
	add_subdirectory(${APPLICATION_EXTERNAL}/nanogui)
endif()
