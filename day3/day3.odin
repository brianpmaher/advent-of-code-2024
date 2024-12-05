package day2

import "core:fmt"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

import "../utils"

main :: proc() {
	data_str := utils.read_file("puzzle-input.txt")

	// xmul(xxx,yyy)
	//      i
	//             j
	//      xxx,yyy 
	//             
	valid_number_strings := make([dynamic]string)
	i := 0
	is_parsing_numbers := false
	for i < len(data_str) {
		char := data_str[i]
		if is_parsing_numbers {
			j := i
			substring_loop: for j < len(data_str) {
				if data_str[j] == ')' {
					is_parsing_numbers = false
					numbers_substr := data_str[i:j]
					comma_count := 0
					for k in numbers_substr {
						if k == ',' {
							comma_count += 1
							continue
						}
						if comma_count > 1 {
							break substring_loop
						}

						k_runes := [1]rune{k}
						k_str := utf8.runes_to_string(k_runes[:])
						_, ok := strconv.parse_int(k_str)
						if !ok {
							break substring_loop
						}
					}
					append(&valid_number_strings, numbers_substr)
					i = j + 1
					break
				} else {
					j = j + 1
				}
			}
		} else if char == 'm' &&
		   i + 1 < len(data_str) &&
		   data_str[i + 1] == 'u' &&
		   i + 2 < len(data_str) &&
		   data_str[i + 2] == 'l' &&
		   i + 3 < len(data_str) &&
		   data_str[i + 3] == '(' {
			i = i + 4
			is_parsing_numbers = true
		} else {
			i = i + 1
		}
	}

	sum_of_multiplications := 0
	for valid_number_str in valid_number_strings {
		valid_number_str_parts := strings.split(valid_number_str, ",")
		number_1_str := valid_number_str_parts[0]
		number_2_str := valid_number_str_parts[1]
		number_1 := strconv.atoi(number_1_str)
		number_2 := strconv.atoi(number_2_str)
		if number_1 > 999 || number_2 > 999 {
			continue
		}
		result := number_1 * number_2
		sum_of_multiplications += result
	}

	fmt.println("Sum of multiplications: ", sum_of_multiplications)
}
