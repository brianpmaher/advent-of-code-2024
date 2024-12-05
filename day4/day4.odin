package day4

import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"

import "../utils"

main :: proc() {
	data_str := utils.read_file("puzzle-input.txt")

	data_str, _ = strings.replace_all(data_str, "\r", "")
	rows := strings.split(data_str, "\n")

	search_matrix := make([dynamic]string)
	for row in rows {
		if row != "" {
			append(&search_matrix, row)
		}
	}

	row_length := len(search_matrix[0])
	col_length := len(search_matrix)

	// Part 1
	{
		xmax_count := 0
		for row, y in search_matrix {
			for cell, x in row {
				if cell == 'X' {
					// N
					if y >= 3 &&
					   search_matrix[y - 1][x] == 'M' &&
					   search_matrix[y - 2][x] == 'A' &&
					   search_matrix[y - 3][x] == 'S' {
						xmax_count += 1
					}
					// NE
					if y >= 3 &&
					   x < row_length - 3 &&
					   search_matrix[y - 1][x + 1] == 'M' &&
					   search_matrix[y - 2][x + 2] == 'A' &&
					   search_matrix[y - 3][x + 3] == 'S' {
						xmax_count += 1
					}
					// E
					if x < row_length - 3 &&
					   search_matrix[y][x + 1] == 'M' &&
					   search_matrix[y][x + 2] == 'A' &&
					   search_matrix[y][x + 3] == 'S' {
						xmax_count += 1
					}
					// SE
					if x < row_length - 3 &&
					   y < col_length - 3 &&
					   search_matrix[y + 1][x + 1] == 'M' &&
					   search_matrix[y + 2][x + 2] == 'A' &&
					   search_matrix[y + 3][x + 3] == 'S' {
						xmax_count += 1
					}
					// S
					if y < col_length - 3 &&
					   search_matrix[y + 1][x] == 'M' &&
					   search_matrix[y + 2][x] == 'A' &&
					   search_matrix[y + 3][x] == 'S' {
						xmax_count += 1
					}
					// SW
					if y < col_length - 3 &&
					   x >= 3 &&
					   search_matrix[y + 1][x - 1] == 'M' &&
					   search_matrix[y + 2][x - 2] == 'A' &&
					   search_matrix[y + 3][x - 3] == 'S' {
						xmax_count += 1
					}
					// W
					if x >= 3 &&
					   search_matrix[y][x - 1] == 'M' &&
					   search_matrix[y][x - 2] == 'A' &&
					   search_matrix[y][x - 3] == 'S' {
						xmax_count += 1
					}
					// NW
					if y >= 3 &&
					   x >= 3 &&
					   search_matrix[y - 1][x - 1] == 'M' &&
					   search_matrix[y - 2][x - 2] == 'A' &&
					   search_matrix[y - 3][x - 3] == 'S' {
						xmax_count += 1
					}
				}
			}
		}

		fmt.println("XMAX count (part 1):", xmax_count)
	}

	// Part 2
	{
		xmax_count := 0
		for row, y in search_matrix {
			for cell, x in row {
				if cell == 'A' && x > 0 && x < row_length - 1 && y > 0 && y < col_length - 1 {
					// NW - M
					if search_matrix[y - 1][x - 1] == 'M' && search_matrix[y + 1][x + 1] == 'S' {
						// NE - M
						if search_matrix[y - 1][x + 1] == 'M' &&
						   search_matrix[y + 1][x - 1] == 'S' {
							xmax_count += 1
						} else if search_matrix[y - 1][x + 1] == 'S' &&
						   search_matrix[y + 1][x - 1] == 'M' {
							xmax_count += 1
						}
					}
					// NW - S
					if search_matrix[y - 1][x - 1] == 'S' && search_matrix[y + 1][x + 1] == 'M' {
						// NE - M
						if search_matrix[y - 1][x + 1] == 'M' &&
						   search_matrix[y + 1][x - 1] == 'S' {
							xmax_count += 1
						} else if search_matrix[y - 1][x + 1] == 'S' &&
						   search_matrix[y + 1][x - 1] == 'M' {
							xmax_count += 1
						}
					}
				}
			}
		}

		fmt.println("X-MAX count (part 2):", xmax_count)
	}
}
