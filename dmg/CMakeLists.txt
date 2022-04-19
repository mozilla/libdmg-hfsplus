INCLUDE(FindOpenSSL)
INCLUDE(FindZLIB)
INCLUDE(FindBZip2)

IF(NOT ZLIB_FOUND)
	message(FATAL_ERROR "zlib is required for dmg!")
ENDIF(NOT ZLIB_FOUND)
IF(NOT BZIP2_FOUND)
	message(FATAL_ERROR "bzip2 is required for dmg!")
ENDIF(NOT BZIP2_FOUND)

include_directories(${ZLIB_INCLUDE_DIR})
link_directories(${ZLIB_LIBRARIES})
include_directories(${BZIP2_INCLUDE_DIR})
link_directories(${BZIP2_LIBRARIES})

link_directories(${PROJECT_BINARY_DIR}/common ${PROJECT_BINARY_DIR}/hfs)

add_library(dmg adc.c base64.c checksum.c dmgfile.c dmglib.c filevault.c io.c partition.c resources.c udif.c ../includes/dmg/adc.h ../includes/dmg/dmg.h ../includes/dmg/dmgfile.h ../includes/dmg/dmglib.h ../includes/dmg/filevault.h)

IF(OPENSSL_FOUND)
	add_definitions(-DHAVE_CRYPT)
	include_directories(${OPENSSL_INCLUDE_DIR})
	target_link_libraries(dmg ${OPENSSL_CRYPTO_LIBRARY} $<$<BOOL:${OPENSSL_USE_STATIC_LIBS}>:${CMAKE_DL_LIBS}>)
	IF(WIN32)
		TARGET_LINK_LIBRARIES(dmg gdi32)
	ENDIF(WIN32)
ENDIF(OPENSSL_FOUND)

target_link_libraries(dmg common hfs z bz2)

add_executable(dmg-bin dmg.c)
target_link_libraries (dmg-bin dmg)

set_target_properties(dmg-bin PROPERTIES OUTPUT_NAME "dmg")

install(TARGETS dmg-bin DESTINATION bin)

