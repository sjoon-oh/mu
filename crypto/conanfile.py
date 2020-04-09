from conans import ConanFile, CMake

class HelloConan(ConanFile):
    name = "dory-crypto"
    version = "0.0.1"
    license = "MIT"
    #url = "TODO"
    description = "Crypto module"
    topics = ("crypto")
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = {"shared": False}
    generators = "cmake"
    exports_sources = "src/*"

    def requirements(self):
        self.requires("dory-shared/0.0.1")
        self.requires("dory-memstore/0.0.1")
        self.requires("libsodium/1.0.18")

    def build(self):
        cmake = CMake(self)
        cmake.configure(source_folder="src")
        cmake.build()

    def package(self):
        self.copy("*.hpp", dst="include/dory/crypto", src="src")
        self.copy("*.a", dst="lib", keep_path=False)

    def package_info(self):
        self.cpp_info.libs = ["crypto"]
        self.cpp_info.cxxflags = ["-std=c++17", "-g", "-O3", "-Wall", "-Wextra", "-Wpedantic", "-Werror", "-Wno-unused-result"]
