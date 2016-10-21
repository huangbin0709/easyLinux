cmake_minimum_required(VERSION 3.0)
#project name
PROJECT(core)
#head file path
INCLUDE_DIRECTORIES(
./include
../platform
)

SET(STATIC_LIB_PATH ../archive)
SET(DYNAMIC_LIB_PATH ../archive/usr/lib)
LINK_DIRECTORIES(
${STATIC_LIB_PATH} 
${DYNAMIC_LIB_PATH}
)
#source directory
AUX_SOURCE_DIRECTORY(src CORE_SRCS)
#set environment variable
#SET(TEST_MATH
#${DIR_SRCS}
#)
SET(CMAKE_INSTALL_PREFIX /easylinux)
#ADD_DEFINITIONS()
SEPARATE_ARGUMENTS(LINK UNIX_COMMAND ${LINK_LIB})
#SET(EXECUTABLE_OUTPUT_PATH $(PROJECT_BINARY_DIR)/bin)
#add executable file
ADD_EXECUTABLE(core ${CORE_SRCS})
#add link library
TARGET_LINK_LIBRARIES(core dl ${LINK})
install(TARGETS core RUNTIME DESTINATION app/bin)
#install(TARGETS core RUNTIME DESTINATION bin)