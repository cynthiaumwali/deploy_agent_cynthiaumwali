#!/bin/bash

function setup() {
    read -p "Enter version name/number: " version
    parent_directory="attendance_tracker_${version}"
    #check if directory exists
    if [ -d "attendance_tracker_${version}" ]
    then
        echo "Directory already exists. Please choose a different version name/number."
        exit 1
    else
        mkdir -p "$parent_directory" "$parent_directory/Helpers" "$parent_directory/reports"

        cp source_files/attendance_checker.py "$parent_directory/attendance_checker.py"

        cp source_files/assets.csv "$parent_directory/Helpers/assets.csv"

        cp source_files/config.json "$parent_directory/Helpers/config.json"

        cp source_files/reports.log "$parent_directory/reports/reports.log"

        echo "Parent directory and subdirectories created successfully with respective files."

	    read "Do you want to update attendance thresholds? [yes/no]: " choice

        if [[ "$choice"=="yes" ]]
        then
            read "Enter new threshold value for Warning: " warning_value
            read "Enter new threshold value for Failure: " failure_value

            sed -i "s/75/$warning_value/g" "$parent_directory/Helpers/config.json"
            sed -i "s/50/$failure_value/g" "$parent_directory/Helpers/config.json"

            echo "Threshold values updated"

        else
            echo "Attendance threshold values remain unchanged. Proceeding with next step"
        fi

	    trap "Process Interrupted. Bundling the current project state..."; cp "$parent_directory" "${parent_directory}_archive" && rm -r "$parent_directory" SIGINT

	    echo "Checking if python3 exists..."

	    if command -v python3 >/dev/null 
        then 
            echo "Python3 is installed"
        else
            echo "Python3 is not installed"
        fi

        if [ -d "$parent_directory" ] && [ -f "$parent_directory/attendance_checker.py" ] && [ -f "$parent_directory/Helpers/assets.csv" ] && [ -f "$parent_directory/Helpers/config.json" ] && [ -f "$parent_directory/reports/reports.log" ]
        then
            echo "Application directory structure is correct"
        else
            echo "Application directory structure is not correct"
        fi
    fi
}

setup
