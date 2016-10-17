cmake_minimum_required(VERSION 3.0)
#project name
PROJECT(platform)
#head file path
INCLUDE_DIRECTORIES(
../platform
)
#source directory
AUX_SOURCE_DIRECTORY(demo DEMO_FILES)
AUX_SOURCE_DIRECTORY(procmgr PROCMGR_FILES)
#set environment variable
#SET(CMAKE_INSTALL_PREFIX /easylinux)
SET(CMAKE_SKIP_BUILD_RPATH FALSE)
#add executable file
ADD_LIBRARY(platform SHARED ${DEMO_FILES} ${PROCMGR_FILES})
#SET_TARGET_PROPERTIES(platform_core properties version 1.0 SOVERSION 0)
#add link library
#TARGET_LINK_LIBRARIES(core m)
#install(TARGETS platform ARCHIVE DESTINATION lib)
install(TARGETS platform LIBRARY DESTINATION lib)