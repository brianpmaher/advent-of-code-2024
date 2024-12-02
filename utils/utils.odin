package utils

import "core:fmt"
import "core:os"
import "core:strings"

read_file :: proc(path: string) -> string {
	data, success := os.read_entire_file_from_filename(path)
	if !success {
		fmt.println("Error reading file")
		return ""
	}

	data_str := string(data)
	data_str, _ = strings.replace_all(data_str, "\r", "")

	return data_str
}
