#!/bin/bash

# Script to scan a target directory for files with specified extensions
# and ensure they are executable by running 'chmod +x'.
#
# Usage:
#   chmodx.sh <path-to-directory> [file-extensions] [--recursive | -r]
#
# Arguments:
#   <path-to-directory>  : Mandatory. The directory to scan.
#   [file-extensions]    : Optional. Comma-separated list of file extensions
#                          (e.g., "sh,py,pl").
#                          Defaults to "sh" if not provided or if an empty string is passed.
#                          Use "*" to target all files.
#   [--recursive | -r]   : Optional. If present, scan recursively. Otherwise,
#                          scans only the top level of <path-to-directory>.
#
# Examples:
#   chmodx.sh ./scripts                  # Makes .sh files in ./scripts executable (non-recursive)
#   chmodx.sh ./myproject sh,py -r       # Makes .sh and .py files in ./myproject executable (recursive)
#   chmodx.sh ./output "*" --recursive   # Makes all files in ./output executable (recursive)
#   chmodx.sh .                          # Makes .sh files in CWD executable (non-recursive)
#
# When run via npm/pnpm:
#   npm run chmodx-scripts -- .            # Targets current dir for .sh files
#   npm run chmodx-scripts -- ./bin sh,pl -r # Targets ./bin for .sh and .pl files, recursively

set -u # Treat unset variables as an error

# Define colors and emojis
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

EMOJI_ROCKET="🚀"
EMOJI_TARGET="🎯"
EMOJI_SCAN="🔍"
EMOJI_FILE="📄"
EMOJI_OK="✅"
EMOJI_WRENCH="🔧"
EMOJI_ERROR="❌"
EMOJI_INFO="ℹ️"
EMOJI_PARTY="🎉"
EMOJI_SHRUG="🤷"

print_usage() {
    echo "Usage: $(basename "$0") <path-to-directory> [file-extensions] [--recursive | -r]"
    echo "Example: $(basename "$0") ./scripts sh,py --recursive"
}

if [ "$#" -eq 0 ]; then
    echo -e "${EMOJI_ERROR} ${RED}Error: No target directory specified.${NC}" >&2
    print_usage >&2
    exit 1
fi

TARGET_DIR_PATH="$1"
shift # Remove the path from arguments

FILE_EXTENSIONS_INPUT=""
RECURSIVE_SCAN=false

MATCH_ALL_FILES=false
FILE_EXTENSIONS_TO_PROCESS_STR="" # Actual extensions to parse if not MATCH_ALL_FILES
FILE_EXTENSIONS_DISPLAY_STR=""    # For user-facing messages

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -r|--recursive)
            RECURSIVE_SCAN=true
            shift
            ;;
        *)
            # If FILE_EXTENSIONS_INPUT is already set, it's an unknown/extra arg or misplaced flag
            if [ -n "$FILE_EXTENSIONS_INPUT" ]; then
                echo -e "${EMOJI_ERROR} ${RED}Error: Unknown argument or too many extension arguments: '$1'. Ensure extensions are a single comma-separated string.${NC}" >&2
                print_usage >&2
                exit 1
            fi
            FILE_EXTENSIONS_INPUT="$1"
            shift
            ;;
    esac
done

# Determine how to handle file extensions based on user input
if [ "$FILE_EXTENSIONS_INPUT" = "*" ]; then
    MATCH_ALL_FILES=true
    FILE_EXTENSIONS_DISPLAY_STR="all files (*)"
elif [ -z "$FILE_EXTENSIONS_INPUT" ]; then # Omitted or empty string from user
    FILE_EXTENSIONS_TO_PROCESS_STR="sh"
    FILE_EXTENSIONS_DISPLAY_STR="'sh' (default)"
else # Specific extensions provided
    FILE_EXTENSIONS_TO_PROCESS_STR="$FILE_EXTENSIONS_INPUT"
    FILE_EXTENSIONS_DISPLAY_STR="'$FILE_EXTENSIONS_TO_PROCESS_STR'"
fi


echo -e "${CYAN}----------------------------------------${NC}"
echo -e "${EMOJI_TARGET} ${BLUE}Target directory: ${YELLOW}'$TARGET_DIR_PATH'${NC}"
echo -e "${EMOJI_FILE} ${BLUE}File matching: ${YELLOW}${FILE_EXTENSIONS_DISPLAY_STR}${NC}"
echo -e "${EMOJI_SCAN} ${BLUE}Recursive scan: ${YELLOW}${RECURSIVE_SCAN}${NC}"
echo -e "${CYAN}----------------------------------------${NC}"
echo # Blank line

# Check if the target directory exists
if [ ! -d "$TARGET_DIR_PATH" ]; then
    echo -e "${EMOJI_ERROR} ${RED}Error: Target directory '$TARGET_DIR_PATH' not found or is not a directory.${NC}" >&2
    exit 1
fi

files_processed_count=0
files_made_executable_count=0
echo -e "${EMOJI_SCAN} ${BLUE}Scanning for files in '${YELLOW}$TARGET_DIR_PATH${BLUE}'...${NC}"
echo # Blank line

# Use process substitution to allow variables in the while loop to be accessible afterwards.
# Find all files (-type f) ending in .sh, recursively within TARGET_DIR_PATH.
# -print0 and read -r -d $'\0' handle filenames with spaces or special characters.
while IFS= read -r -d $'\0' script_file_path; do
    files_processed_count=$((files_processed_count + 1))
    # echo # Blank line for readability between files for each entry (can be noisy for many files)
    echo -e "${EMOJI_FILE} ${BLUE}Processing file: ${YELLOW}'$script_file_path'${NC}"

    if [ -x "$script_file_path" ]; then
        echo -e "  ${EMOJI_OK} ${GREEN}Already executable.${NC}"
    else
        echo -e "  ${EMOJI_WRENCH} ${YELLOW}Setting execute permission...${NC}"
        chmod +x "$script_file_path"
        if [ $? -eq 0 ]; then
            echo -e "  ${EMOJI_OK} ${GREEN}Successfully made '$script_file_path' executable.${NC}"
            files_made_executable_count=$((files_made_executable_count + 1))
        else
            echo -e "  ${EMOJI_ERROR} ${RED}Error: Failed to make '$script_file_path' executable. Check permissions.${NC}" >&2
            # Script continues to process other files
        fi
    fi
done < <(
    find_args=("$TARGET_DIR_PATH")
    if ! $RECURSIVE_SCAN; then
        find_args+=("-maxdepth" "1")
    fi
    find_args+=("-type" "f")

    # Add -name conditions only if not matching all files
    if ! $MATCH_ALL_FILES; then
        IFS=',' read -r -a extensions_array <<< "$FILE_EXTENSIONS_TO_PROCESS_STR"
        if [ "${#extensions_array[@]}" -gt 0 ]; then
            has_name_condition=false
            name_conditions=()
            for ext_val in "${extensions_array[@]}"; do
                trimmed_ext=$(echo "$ext_val" | tr -d '[:space:]') # Trim whitespace
                if [ -n "$trimmed_ext" ]; then
                    if [ "${#name_conditions[@]}" -gt 0 ]; then
                        name_conditions+=("-o") # OR operator
                    fi
                    name_conditions+=("-name" "*.$trimmed_ext")
                    has_name_condition=true
                fi
            fi
            if $has_name_condition; then
                 find_args+=("(") "${name_conditions[@]}" (")")
            fi
        fi
    fi
    find_args+=("-print0")
    # echo "Debug: find command: find ${find_args[*]}" # Uncomment for debugging find
    find "${find_args[@]}"
)

echo # Blank line
echo -e "${CYAN}----------------------------------------${NC}"
if [ "$files_processed_count" -eq 0 ]; then
    echo -e "${EMOJI_SHRUG} ${YELLOW}No files matching ${FILE_EXTENSIONS_DISPLAY_STR} found in '$TARGET_DIR_PATH'${NC}${RECURSIVE_SCAN:+ (recursive search)}."
else
    echo -e "${EMOJI_INFO} ${BLUE}Finished processing ${YELLOW}$files_processed_count${BLUE} matching file(s).${NC}"
    if [ "$files_made_executable_count" -gt 0 ]; then
        echo -e "  ${EMOJI_OK} ${GREEN}$files_made_executable_count file(s) had their execute permission set.${NC}"
    else
        echo -e "  ${EMOJI_INFO} ${BLUE}No files required changes to their execute permissions (all were already executable or no matching files found that were not executable).${NC}"
    fi
fi
echo -e "${EMOJI_PARTY} ${GREEN}Script finished.${NC}"
echo -e "${CYAN}----------------------------------------${NC}"

exit 0
