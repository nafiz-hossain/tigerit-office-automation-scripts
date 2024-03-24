def extract_lines_with_prefix(input_file, output_file, prefixes):
    # Create a dictionary to hold lines for each prefix
    lines_by_prefix = {prefix: [] for prefix in prefixes}

    with open(input_file, 'r') as infile:
        lines = infile.readlines()

    # Collect lines for each prefix
    for line in lines:
        for prefix in prefixes:
            if line.strip().startswith(prefix):
                lines_by_prefix[prefix].append(line.strip())
                break

    # Write collected lines to the output file grouped by prefix
    with open(output_file, 'w') as outfile:
        for prefix, lines in lines_by_prefix.items():
            if lines:  # Check if there are any lines for the prefix
                outfile.write(f"{prefix}\n")  # Write prefix
                for line in lines:
                    outfile.write(f"{line}\n")  # Write lines for the prefix
                outfile.write("\n")  # Add an empty line after each group

if __name__ == "__main__":
    input_file = "input.txt"  # Change this to your input file path
    output_file = "output.txt"  # Change this to your output file path
    prefixes = [
        "#420-Message Read Status:',",
        "#420-Message Delivered Status:',",
        "#420-Message Status Last Updated Time:',"
    ]  # Change this to your desired prefixes

    extract_lines_with_prefix(input_file, output_file, prefixes)

