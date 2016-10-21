cmake_minimum_required(VERSION 3.0)
#project name
PROJECT(procmgr)
#head file path
INCLUDE_DIRECTORIES(
./include
../platform
)

SET(STATIC_LIB_PATH ../archive)
SET(DYNAMIC_LIB_PATH ../archive/usr/lib)
LINK_DIRECTORIES(
${STATIC_LIB_PATH}
${DYNAMIC_LIB_PATH})
#source directory
AUX_SOURCE_DIRECTORY(src PROCMGR_FILES)
#set environment variable
#SET(CMAKE_INSTALL_PREFIX /easylinux)
SEPARATE_ARGUMENTS(LINK UNIX_COMMAND ${LINK_LIB})
#add executable file
ADD_EXECUTABLE(procmgr ${PROCMGR_FILES})
#add link library
TARGET_LINK_LIBRARIES(procmgr pthread dl ${LINK})
install(TARGETS procmgr RUNTIME DESTINATION bin)