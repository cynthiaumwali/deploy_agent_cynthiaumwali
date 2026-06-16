# Student Attendance Tracker - Project Factory

## Description: 
A shell script that automates the creation of the workspace, configures settings via the command line, and handles system signals gracefully.

## 1. Directory Architecture
Script automatically creates parent directory with source files in their respective parent directories upon receiving user input. If the user input is missing, the script re-prompts the user to enter a value. If there exists a directory with the same name as the one generated after appending the user input, the user is also notified that the directory exists and re-prompted to enter a new value. If the user has no permissions to create the directories/files, the script notifies the user and exits.

## 2. Dynamic Configuration (Stream Editing)
Script asks the user whether they want to update attendance thresholds. If the user enters **yes** as the choice, script takes their input for both warning and failure values. If either value is not a positive number, or either value is greater than 100, the script re-prompts the user to enter valid values. If the values are valid, the script the updates **config.json**'s initial values with the newly provided values. If the user enters **no** as the choice, the scripts proceeds to the next step. If the user enters a different choice from the provided ones, he/she is notified and re-prompted to enter the correct choice [**yes**/**no**].

## 3. Process Management (The Trap)
The script also handles SIGINT [CTRL+C] Signal using the **trap** command. If the user cancels the script mid-execution (presses [CTRL+C]), the script catches the signal, bundles the current state of the project into an archive file and deletes the incomplete directory for cleanliness. At first, I had the trap command inside the setup function in the middle of other instructions, therefore, it couldn't catch interrupts for processes defined before it. I corrected this by placing it at the very beginning of the function, before any other process, so that any interrupt is handled as soon as the script starts running.

## 4. Environment Validation
The script also verifies whether the user has **python3** installed on their computer and issues a warning if it's not installed. Lastly, the script verifies if the generated parent directory has followed the wanted structure. 


## How to run this script:


First, make the script executable. In your terminal, navigate to your repository and type this command below:


```bash  
chmod +x setup.sh
```


Now that you have the permission to execute the file, run it as follow:


```bash
./setup.sh
```

Then follow the prompts in the script by entering an input that will serve as version name/number and choosing whether to update the attendance thresholds. 


## How to Trigger the Archive Feature

While the script is running at any step, press **CTRL+C**. This will interrupt the script and triggers the trap, which will perform the following once the signal is caught:


- If a parent directory has already been created, it gets compressed into <parent_directory>_archive.tar.gz and the original, incomplete directory is deleted.

- If parent directory hasn't been created yet, meaning the script was interrupted before the user input was captured, the script simply exits with a notice that there was nothing to bundle.

## Run-through Video

This is the link of my video, explaining my approach to the solution: https://youtu.be/DEXEhad_Ov8