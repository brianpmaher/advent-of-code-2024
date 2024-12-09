package day5

import "core:fmt"
import "core:strconv"
import "core:strings"

import "../utils"

Update :: int

Rule :: struct {
	before: Update,
	after:  Update,
}

Update_List :: [dynamic]Update

main :: proc() {
	data_str := utils.read_file("test-input.txt")
	data_str, _ = strings.replace_all(data_str, "\r", "")
	lines := strings.split(data_str, "\n")

	rules_lines := make([dynamic]string)
	updates_lines := make([dynamic]string)
	started_update := false
	for line in lines {
		if line == "" {
			if !started_update {
				started_update = true
			}
		} else {
			if !started_update {
				append(&rules_lines, line)
			} else {
				append(&updates_lines, line)
			}
		}
	}

	rules := make([dynamic]Rule)
	for rule_line in rules_lines {
		rule_parts := strings.split(rule_line, "|")
		before, _ := strconv.parse_int(rule_parts[0])
		after, _ := strconv.parse_int(rule_parts[1])
		rule := Rule {
			before = before,
			after  = after,
		}
		append(&rules, rule)
	}

	updates := make([dynamic]Update_List)
	for update_line in updates_lines {
		update_parts := strings.split(update_line, ",")
		update_list := make(Update_List)
		for update_part in update_parts {
			update, _ := strconv.parse_int(update_part)
			append(&update_list, update)
		}
		append(&updates, update_list)
	}

	fmt.println(rules)
	fmt.println(updates)

	// TODO: Complete Day 5 Part 1
}
