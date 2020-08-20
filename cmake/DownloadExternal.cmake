################################################################################
include(DownloadProject)

# Shortcut function
function(application_download_project name)
    download_project(
        PROJ         ${name}
        SOURCE_DIR   ${APPLICATION_EXTERNAL}/${name}
        DOWNLOAD_DIR ${APPLICATION_EXTERNAL}/.cache/${name}
        ${ARGN}
    )
endfunction()

################################################################################

## nanogui
function(application_download_nanogui)
    application_download_project( nanogui
        GIT_REPOSITORY https://github.com/wjakob/nanogui.git
        GIT_TAG        master
    )
endfunction()


