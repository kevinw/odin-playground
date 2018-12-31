package path

import "core:os"
import "core:strings"

dir_name :: proc(path: string) -> string {
    when os.OS == "windows" {
        last_path_separator_index := strings.last_index_byte(path, '\\');
    } else {
        #assert(false, "TODO");
    }

    if last_path_separator_index == -1 do return "";

    slice := path[:last_path_separator_index];

    return string(slice);
}
