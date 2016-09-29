cmake_minimum_required(VERSION 3.0)
#project name
PROJECT(platform)
#head file path
INCLUDE_DIRECTORIES(
../platform
)
#source directory
AUX_SOURCE_DIRECTORY(demo DEMO_FILES)
#set environment variable
#SET(CMAKE_INSTALL_PREFIX /easylinux)
#add executable file
ADD_LIBRARY(platform SHARED ${DEMO_FILES})
#add link library
#TARGET_LINK_LIBRARIES(core m)
install(TARGETS platform LIBRARY DESTINATION lib)