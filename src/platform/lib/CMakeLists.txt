cmake_minimum_required(VERSION 3.0)
#project name
PROJECT(platform)
#head file path
INCLUDE_DIRECTORIES(
../platform
./gdsl/include
../platform/gdsl
)
#source directory
AUX_SOURCE_DIRECTORY(demo DEMO_FILES)
AUX_SOURCE_DIRECTORY(procmgr PROCMGR_FILES)
AUX_SOURCE_DIRECTORY(gdsl/src GDSL_FILES)
AUX_SOURCE_DIRECTORY(crypto/xyssl XYSSL_FILES)
AUX_SOURCE_DIRECTORY(init INIT_FILES)
#set environment variable
SET(BASE_FILES base/pid.c base/mid.c base/base_core.c base/mm_plugin.c)
SET(BASE_MOD_FILES base/base_mod.c)
SET(CMAKE_SKIP_BUILD_RPATH FALSE)
#add executable file
ADD_LIBRARY(platform SHARED ${DEMO_FILES} ${PROCMGR_FILES} ${GDSL_FILES} ${XYSSL_FILES} ${INIT_FILES} ${BASE_FILES})
ADD_LIBRARY(platform_mod SHARED ${BASE_MOD_FILES})
#SET_TARGET_PROPERTIES(platform_core properties version 1.0 SOVERSION 0)
#add link library
#TARGET_LINK_LIBRARIES(core m)
#install(TARGETS platform ARCHIVE DESTINATION lib)
install(TARGETS platform LIBRARY DESTINATION lib)
install(TARGETS platform_mod LIBRARY DESTINATION lib)