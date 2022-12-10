cmake_minimum_required(VERSION 3.24)
project(SimpleCppLib)
set(SimpleCppLib_VERSION 1.0.0)

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

add_library(foo STATIC src/foo.cpp include/foo.hpp)
add_library(SimpleCppLib::foo ALIAS foo)
target_include_directories(foo
	PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
		$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

add_executable(main src/main.cpp)
target_link_libraries(main foo)

configure_package_config_file(cmake/config.cmake.in
	${CMAKE_CURRENT_BINARY_DIR}/SimpleCppLib-config.cmake
	INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/SimpleCppLib
	NO_SET_AND_CHECK_MACRO)
write_basic_package_version_file(
	${CMAKE_CURRENT_BINARY_DIR}/SimpleCppLib-config-version.cmake
	VERSION ${SimpleCppLib_VERSION}
	COMPATIBILITY SameMajorVersion
    )
install(
	FILES
		${CMAKE_CURRENT_BINARY_DIR}/SimpleCppLib-config.cmake
		${CMAKE_CURRENT_BINARY_DIR}/SimpleCppLib-config-version.cmake
	DESTINATION
		${CMAKE_INSTALL_DATADIR}/SimpleCppLib)

install(TARGETS foo 
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

install(TARGETS foo EXPORT SimpleCppLib-targets)
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT SimpleCppLib-targets
	NAMESPACE SimpleCppLib::
	DESTINATION ${CMAKE_INSTALL_DATADIR}/SimpleCppLib)