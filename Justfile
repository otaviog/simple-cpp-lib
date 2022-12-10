set shell := ["powershell.exe", "-c"]

build:
    cmake -B build . -DCMAKE_INSTALL_PREFIX=build/install
    cmake --build build --target install
    