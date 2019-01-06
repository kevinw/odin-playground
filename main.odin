package main

import main_pkg "vulkan_buffers"

import "core:os"

when os.OS == "windows" do import "core:sys/win32"

main :: proc() {
    ret_code := main_pkg.run();

    when os.OS == "windows" do win32.exit_process(cast(u32)ret_code);
}

