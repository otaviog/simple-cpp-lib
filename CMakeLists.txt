cmake_minimum_required(VERSION 3.24)
project(ProjectName)
add_library(foo foo.cpp)

add_executable(main main.cpp)
target_link_libraries(main foo)

install(TARGETS foo 
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)