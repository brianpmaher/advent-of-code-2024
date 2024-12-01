package day1

import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"

INPUT_FILE :: "puzzle-input.txt"

main :: proc() {
	data, success := os.read_entire_file_from_filename(INPUT_FILE)
	if !success {
		fmt.println("Error reading file")
		return
	}

	data_str := string(data)

	fmt.printf(data_str)

	data_str, _ = strings.replace_all(data_str, "\r", "")
	rows, _ := strings.split(data_str, "\n")
	left_ints := make([dynamic]int)
	right_ints := make([dynamic]int)

	for row in rows {
		if row == "" {
			continue
		}

		row_numbers, _ := strings.split(row, "   ")
		fmt.println(row_numbers)
		left_int := strconv.atoi(row_numbers[0])
		append(&left_ints, left_int)
		right_int := strconv.atoi(row_numbers[1])
		append(&right_ints, right_int)
	}

	fmt.printfln("Left: %d", left_ints)
	fmt.printfln("Right: %d", right_ints)

	slice.sort(left_ints[:])
	slice.sort(right_ints[:])

	fmt.println("Sorted")
	fmt.printfln("Left: %d", left_ints)
	fmt.printfln("Right: %d", right_ints)

	ints_count := len(left_ints)
	sum_of_differences := 0
	for i in 0 ..< ints_count {
		sum_of_differences += abs(left_ints[i] - right_ints[i])
	}

	fmt.printfln("Sum of differences: %d", sum_of_differences)
}
