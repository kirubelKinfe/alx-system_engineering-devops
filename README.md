# Shell, Init Files, Variables, and Expansions

This project covers shell initialization files, variables, expansions, and basic shell scripting in Bash.

## Project Tasks

### 0. Create an alias
**File:** `0-alias`  
Creates an alias `ls` that executes `rm *` (removes all files in current directory)

### 1. Print hello user
**File:** `1-hello_you`  
Prints "hello" followed by the current Linux username

### 2. Add to PATH
**File:** `2-path`  
Adds `/action` to the PATH environment variable (last directory searched)

### 3. Count PATH directories
**File:** `3-paths`  
Counts and prints the number of directories in the PATH variable

### 4. List environment variables
**File:** `4-global_variables`  
Lists all environment variables

### 5. List all variables and functions
**File:** `5-local_variables`  
Lists all local variables, environment variables, and functions

### 6. Create local variable
**File:** `6-create_local_variable`  
Creates a local variable `BEST` with value "School"

### 7. Create global variable
**File:** `7-create_global_variable`  
Creates a global variable `BEST` with value "School"

### 8. Arithmetic with environment variable
**File:** `8-true_knowledge`  
Prints the result of adding 128 to the value stored in `TRUEKNOWLEDGE`

### 9. Division of environment variables
**File:** `9-divide_and_rule`  
Prints the result of `POWER` divided by `DIVIDE`

### 10. Exponentiation
**File:** `10-love_exponent_breath`  
Prints the result of `BREATH` to the power of `LOVE`

### 11. Binary to decimal
**File:** `11-binary_to_decimal`  
Converts a binary number in `BINARY` to decimal

### 12. Letter combinations
**File:** `12-combinations`  
Prints all possible two-letter combinations (a-z) except 'oo'

### 13. Print float
**File:** `13-print_float`  
Prints a number with two decimal places from the `NUM` environment variable

## Requirements
- All scripts are exactly 2 lines long
- First line is exactly `#!/bin/bash`
- No use of `&&`, `||`, `;`, `bc`, `sed`, or `awk`
- All files are executable
- All files end with a newline

## Concepts Covered
- Shell initialization files (`/etc/profile`, `~/.bashrc`)
- Local vs global variables
- Variable creation, updating, and deletion
- Special parameters (`$?`, `$$`, etc.)
- Expansions (parameter, command substitution, arithmetic)
- Single vs double quotes
- Shell arithmetic operations
- Alias creation and management

## How to Use
1. Clone the repository
2. Make scripts executable: `chmod +x [filename]`
3. For scripts that modify environment variables, run with `source`:  
   `source [filename]`
4. For others, execute directly:  
   `./[filename]`