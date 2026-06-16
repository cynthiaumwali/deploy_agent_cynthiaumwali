#!/bin/bash

parent_directory=""

#3. Handle SIGINT [Ctrl+C] using the TRAP command
    trap '  echo -e "\nProcess Interrupted. Bundling the current project state.."
    if [[ -d "$parent_directory" ]]
    then
        tar -czf "${parent_directory}_archive.tar.gz" "$parent_directory" && rm -rf "$parent_directory"
        echo -e "\nProject state bundled into ${parent_directory}_archive.tar.gz. Original directory is deleted."
    else
        echo -e "\nParent directory not set yet. No bundling performed. Exiting.."
    fi
    exit 1' SIGINT


function setup() {
    #1.create parent directory and subdirectories with respective files
    read -p "Enter version name/number: " version

    if [[ -z "$version" ]]
    then
        echo "Version name/number cannot be empty."
        continue
    fi

    parent_directory="attendance_tracker_${version}"

    if [[ -d "attendance_tracker_${version}" ]]
    then
        echo "Directory already exists. Please choose a different version name/number."
        exit 1
    else
        mkdir -p "$parent_directory" "$parent_directory/Helpers" "$parent_directory/reports"

        if [[ $? -ne 0 ]]
        then
            echo "Failed to create directories. Please check permissions and try again."
            exit 1
        fi

        cp source_files/attendance_checker.py "$parent_directory/attendance_checker.py"

        if [[ $? -ne 0 ]]
        then
            echo "Failed to copy attendance_checker.py. Please check permissions and try again."
            exit 1
        fi

        cp source_files/assets.csv "$parent_directory/Helpers/assets.csv"

        if [[ $? -ne 0 ]]
        then
            echo "Failed to copy assets.csv. Please check permissions and try again."
            exit 1
        fi

        cp source_files/config.json "$parent_directory/Helpers/config.json"

        if [[ $? -ne 0 ]]
        then
            echo "Failed to copy config.json. Please check permissions and try again."
            exit 1
        fi

        cp source_files/reports.log "$parent_directory/reports/reports.log"

        if [[ $? -ne 0 ]]
        then
            echo "Failed to copy reports.log. Please check permissions and try again."
            exit 1
        fi

        echo "Parent directory and subdirectories created successfully with respective files."

	    read -p "Do you want to update attendance thresholds? [yes/no]: " choice

    #2. Dynamic threshold configuration
        if [[ "$choice" == "yes" || "$choice" == "YES" ]]
        then
            read -p "Enter new threshold value for Warning: " warning_value
            read -p "Enter new threshold value for Failure: " failure_value

            if [[ "$warning_value" =~ ^[+-]?[0-9]*\.?[0-9]+$ || "$failure_value" =~ ^[+-]?[0-9]*\.?[0-9]+$ ]]
            then
                echo "Invalid input. Attendance threshold values must be numbers."
                exit 1
            fi

            sed -i "s/75/$warning_value/g" "$parent_directory/Helpers/config.json"
            sed -i "s/50/$failure_value/g" "$parent_directory/Helpers/config.json"

            echo "Threshold values updated"
            

        elif [[ "$choice" == "no" || "$choice" == "NO" ]]
        then
            echo "Attendance threshold values remain unchanged. Proceeding with next step"

        else
            echo "You entered an invalid choice. Please enter 'yes' or 'no'."
            exit 1
        fi

    #4. Environment validation [Checking if python3 is installed & verifying application directory structure]
	    echo "Checking if python3 exists.."

	    if command -v python3 
        then 
            echo "Python3 is installed"
        else
            echo "Python3 is not installed"
        fi

        if [[ -d "$parent_directory" ]] && [[ -f "$parent_directory/attendance_checker.py" ]] && [[ -f "$parent_directory/Helpers/assets.csv" ]] && [[ -f "$parent_directory/Helpers/config.json" ]] && [[ -f "$parent_directory/reports/reports.log" ]]
        then
            echo "Application directory structure is correct"
        else
            echo "Application directory structure is not correct"
        fi
    fi
}

setup
