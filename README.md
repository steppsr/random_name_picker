# random_name_picker

Create a list of 1 or 2 word random names.

Names may have duplicates unless you use the `-u` command-line option to force the names to be unique.

# Command Usage

```
USAGE: bash random_name_picker.sh [OPTIONS]

  OPTIONS
   -u          Force names to be unique.
   -i INTEGER  Number of names to create.
   -f1 FILE    File containing first names. File must have one per line and no blank lines.
   -f2 FILE    File containing last names. File must have one per line and no blank lines.
   -h          Help
   -v          Current version & version history.

   Example:
      bash random_name_picker.sh -u -i 10 -f1 firstnames.txt -f2 lastnames.txt

   Example for saving to file:
      bash random_name_picker.sh -u -i 10 -f1 firstnames.txt -f2 lastnames.txt > names_list.txt

```

# Versions
Current version: 0.1

Version 0.1 - Initial version with basic functionality to choose 1 word names, or 2 word names.
              Name can be unique or allow duplicates.
