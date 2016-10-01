cmake_minimum_required(VERSION 3.0)
#project name
PROJECT(demo)
#head file path
INCLUDE_DIRECTORIES(
include
../platform
)
LINK_DIRECTORIES(../arvhive)
#source directory
AUX_SOURCE_DIRECTORY(src DEMO_SRCS)
#ADD_DEFINITIONS()
#SEPARATE_ARGUMENTS()
#SET(EXECUTABLE_OUTPUT_PATH $(PROJECT_BINARY_DIR)/bin)
#add executable file
ADD_LIBRARY(demo STATIC ${DEMO_SRCS})
#add link library
#TARGET_LINK_LIBRARIES(core m)
#不安装到usr目录下，安装到destdir目录
install(TARGETS demo ARCHIVE DESTINATION ../)