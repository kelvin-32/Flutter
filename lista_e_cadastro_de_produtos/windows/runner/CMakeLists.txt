cmake_minimum_required(VERSION 3.14)
project(runner LANGUAGES CXX)

# Certifique-se de que BINARY_NAME está definido
if(NOT DEFINED BINARY_NAME)
  set(BINARY_NAME "runner")
endif()

# Defina o diretório gerenciado pelo Flutter, se não estiver definido
if(NOT DEFINED FLUTTER_MANAGED_DIR)
  set(FLUTTER_MANAGED_DIR "${CMAKE_SOURCE_DIR}/../.dart_tool/flutter/ephemeral")
endif()

set(SOURCE_FILES
  "flutter_window.cpp"
  "main.cpp"
  "utils.cpp"
  "win32_window.cpp"
  "Runner.rc"
  "runner.exe.manifest"
)

# Adicione o arquivo generated_plugin_registrant.cc se ele existir
set(GENERATED_PLUGIN_REGISTRANT "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc")
if(EXISTS "${GENERATED_PLUGIN_REGISTRANT}")
  list(APPEND SOURCE_FILES "${GENERATED_PLUGIN_REGISTRANT}")
else()
  message(WARNING "AVISO: Arquivo ${GENERATED_PLUGIN_REGISTRANT} não encontrado. Isso é comum em builds limpos e não impede a compilação. Execute 'flutter build windows' ou 'flutter run' para gerá-lo automaticamente. Um stub temporário será usado até lá.")
  # Cria um stub vazio para evitar erro de build
  file(WRITE "${CMAKE_BINARY_DIR}/generated_plugin_registrant.cc" "// Stub gerado automaticamente\n")
  list(APPEND SOURCE_FILES "${CMAKE_BINARY_DIR}/generated_plugin_registrant.cc")
endif()

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt, not the value here, or `flutter run` will no longer
# work.
#
# Any new source files that you add to the application should be added here.
add_executable(${BINARY_NAME} WIN32 ${SOURCE_FILES})

# Apply the standard set of build settings. This can be removed for applications
# that need different build settings.
# apply_standard_settings(${BINARY_NAME}) # Removed because this command is not defined
# You can add standard CMake settings here if needed, for example:
set_target_properties(${BINARY_NAME} PROPERTIES CXX_STANDARD 17 CXX_STANDARD_REQUIRED YES)

# Add preprocessor definitions for the build version.
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION=\"${FLUTTER_VERSION}\"")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MAJOR=${FLUTTER_VERSION_MAJOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MINOR=${FLUTTER_VERSION_MINOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_PATCH=${FLUTTER_VERSION_PATCH}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_BUILD=${FLUTTER_VERSION_BUILD}")

# Disable Windows macros that collide with C++ standard library functions.
target_compile_definitions(${BINARY_NAME} PRIVATE "NOMINMAX")

# Add dependency libraries and include directories. Add any application-specific
# dependencies here.
target_link_libraries(${BINARY_NAME} PRIVATE flutter flutter_wrapper_app)
target_link_libraries(${BINARY_NAME} PRIVATE "dwmapi.lib")
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")

# Run the Flutter tool portions of the build. This must not be removed.
set(FLUTTER_ASSEMBLE_CMAKE "${FLUTTER_MANAGED_DIR}/flutter_assemble.cmake")
if(EXISTS "${FLUTTER_ASSEMBLE_CMAKE}")
  include("${FLUTTER_ASSEMBLE_CMAKE}")
  add_dependencies(${BINARY_NAME} flutter_assemble)
else()
  message(WARNING "AVISO: Arquivo flutter_assemble.cmake não encontrado em ${FLUTTER_ASSEMBLE_CMAKE}. Isso é esperado em builds limpos. Execute 'flutter build windows' ou 'flutter run' para gerá-lo e evitar este aviso.")
  # Não adiciona a dependência se o arquivo não existir
endif()
