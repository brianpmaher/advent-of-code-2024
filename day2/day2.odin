package day2

import "core:fmt"
import "core:strconv"
import "core:strings"

import "../utils"

Report_Type :: enum {
	Unknown,
	Increasing,
	Decreasing,
}

Level :: int

Report :: struct {
	type:    Report_Type,
	levels:  [dynamic]Level,
	is_safe: bool,
}

main :: proc() {
	data_str := utils.read_file("puzzle-input.txt")
	report_strings := strings.split(data_str, "\n")

	reports := make([dynamic]Report)
	for report_str in report_strings {
		if report_str == "" {
			continue
		}

		level_strings := strings.split(report_str, " ")

		report := Report {
			levels = make([dynamic]Level),
		}

		for level_str in level_strings {
			level: Level = strconv.atoi(level_str)
			append(&report.levels, level)
		}

		append(&reports, report)
	}

	report_loop: for &report in reports {
		report.is_safe = false
		first_level := report.levels[0]
		second_level := report.levels[1]
		if first_level < second_level {
			report.type = .Increasing
		} else if first_level > second_level {
			report.type = .Decreasing
		}

		if report.type == .Unknown {
			continue
		}

		fmt.println("========== Starting report scan ==========")
		fmt.println(report)
		prev_level := first_level
		for level, i in report.levels[1:] {
			if report.type == .Increasing {
				if level < prev_level {
					fmt.println("Report should be increaseing, but is decreasing")
					continue report_loop
				}
			} else if report.type == .Decreasing {
				if level > prev_level {
					fmt.println("Report should be decreaseing, but is increasing")
					continue report_loop
				}
			}

			difference := abs(prev_level - level)
			if difference < 1 || difference > 3 {
				fmt.println("Report report difference too small or too big")
				continue report_loop
			}

			if i == len(report.levels) - 2 {
				fmt.println("Report is safe")
				report.is_safe = true
			}
			prev_level = level
		}
	}

	sum_safe := 0
	for report in reports {
		if report.is_safe {
			sum_safe += 1
		}
	}

	fmt.printfln("Safe reports: %d", sum_safe)
}

// The levels are either all increasing or all decreasing.
// Any two adjacent levels differ by at least one and at most three.
is_safe_report :: proc(report: []int) -> bool {
	return false
}
