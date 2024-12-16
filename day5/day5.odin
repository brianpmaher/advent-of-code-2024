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
	data_str := utils.read_file("puzzle-input.txt")
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

	update_lists := make([dynamic]Update_List)
	for update_line in updates_lines {
		update_parts := strings.split(update_line, ",")
		update_list := make(Update_List)
		for update_part in update_parts {
			update, _ := strconv.parse_int(update_part)
			append(&update_list, update)
		}
		append(&update_lists, update_list)
	}

	// fmt.println(rules)
	// fmt.println(update_lists)

	correct_update_lists := make([dynamic]Update_List)
	for update_list in update_lists {
		// Determine relevant rules
		relevant_rules := make([dynamic]Rule)
		for rule in rules {
			rule_number_count := 0
			for update in update_list {
				if update == rule.before || update == rule.after {
					rule_number_count += 1
				}
				if rule_number_count == 2 {
					break
				}
			}
			if rule_number_count == 2 {
				append(&relevant_rules, rule)
			}
		}

		// Apply relevant rules
		is_valid := true
		for rule in relevant_rules {
			before_found := false
			for update in update_list {
				if rule.before == update {
					before_found = true
				}
				if rule.after == update && !before_found {
					is_valid = false
				}
			}
		}
		if is_valid {
			append(&correct_update_lists, update_list)
		}
	}

	sum_of_middles := 0
	for update_list in correct_update_lists {
		update := update_list[len(update_list) / 2]
		sum_of_middles += update
	}

	fmt.println("Sum of middles:", sum_of_middles)
}
