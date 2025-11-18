option(USING_NIX "Enabled when a Nix build has started" OFF)

cmake_minimum_required(VERSION 3.30)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(USING_NIX)
  project(${NIX_PROJECT_NAME} CXX)
else()
  project(App CXX)
endif()

set(SOURCE_FILES
  src/main.cpp
  src/hello-template.cpp
)

# Define a debug mode macro:
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  add_compile_definitions(DEBUG_BUILD)

  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -g3")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -g3")
endif()

add_executable(${PROJECT_NAME} WIN32 ${SOURCE_FILES})

# Include directories
target_include_directories(${PROJECT_NAME} PRIVATE
  "${CMAKE_SOURCE_DIR}/include"
)

# Extra Debug tools for Linux:
if(CMAKE_BUILD_TYPE STREQUAL "Debug" AND UNIX AND NOT APPLE)
  message(VERBOSE "Debug build detected, linking fsanitize and ggdb")
  target_compile_options(${PROJECT_NAME} PRIVATE -fsanitize=address,undefined -ggdb)
  target_link_options(${PROJECT_NAME} PRIVATE -fsanitize=address,undefined)
endif()

# Fallback for clangd in Nix not finding standard libs.
if(CMAKE_EXPORT_COMPILE_COMMANDS AND USING_NIX)
  message(STATUS "Using Nix clangd workaround")
  set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES 
      ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin)
