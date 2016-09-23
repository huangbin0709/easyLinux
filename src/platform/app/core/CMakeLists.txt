cmake_minimum_required(VERSION 3.0)
#project name
PROJECT(core)
#head file path
INCLUDE_DIRECTORIES(
include
../platform
)
#source directory
AUX_SOURCE_DIRECTORY(src DIR_SRCS)
#set environment variable
SET(TEST_MATH
${DIR_SRCS}
)
SET(CMAKE_INSTALL_PREFIX /easylinux)
#add executable file
ADD_EXECUTABLE(core ${TEST_MATH})
#add link library
#TARGET_LINK_LIBRARIES(core m)
install(TARGETS core RUNTIME DESTINATION app/sbin)