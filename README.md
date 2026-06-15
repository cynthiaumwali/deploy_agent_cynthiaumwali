# Student Attendance Tracker - Project Factory

## Description: 
A shell script that automates the creation of the workspace, configures settings via the command line, and handles system signals gracefully.

## 1. Directory Architecture
Script automatically creates parent directory with source files in their respective parent directories upon receiving user input. 

## 2. Dynamic Configuration (Stream Editing)
Script asks the user whether they want to update attendance thresholds. If the user enters **yes** as the choice, script takes their input for both warning and failure values and updates **config.json**'s initial values with the newly provided values.

## 3. Process Management (The Trap)
The script also handles SIGINT [Ctrl+c] Signal using the **trap** command. If the user cancels the script mid-execution, the script catches the signal, bundles the current state of the project into an archive directory and deletes the incomplete directory for cleanliness.

## 4. Environment Validation
The script also verifies whether the user has **python3** installed on their computer and issues a warning if it's not installed. Lastly, the script verifies if the generated parent directory has followed the desired structure. 