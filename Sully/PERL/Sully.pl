#!/bin/perl

# The source code of the script itself, stored as a string
$source_code = '#!/bin/perl%1$c%1$c$source_code = %2$c%4$s%2$c;%1$c%1$c$counter = %3$d;%1$cif ($counter <= 0) {%1$c    exit;%1$c} elsif ($ENV{CHILD_PROCESS}) {%1$c    $counter--;%1$c}%1$c$script_name = "Sully_$counter.pl";%1$copen(my $file_handle, ">$script_name") or exit;%1$cchmod 0755, $script_name;%1$cprintf $file_handle $source_code, 10, 39, $counter, $source_code;%1$cclose($file_handle);%1$c$ENV{CHILD_PROCESS} = "CHILD_PROCESS";%1$cif ($counter) {%1$c    system("./Sully_$counter.pl");%1$c}%1$c';

# Initialize the counter
$counter = 5;

# Exit if the counter is less than or equal to 0
if ($counter <= 0) {
	exit;
} elsif ($ENV{CHILD_PROCESS}) {
	# Decrement the counter if this is a child process
	$counter--;
}

# Generate the script name based on the counter
$script_name = "Sully_$counter.pl";

# Open a new file with the generated script name for writing
open(my $file_handle, ">$script_name") or exit;

# Set the file permissions to be executable
chmod 0755, $script_name;

# Write the source code to the new file, replacing placeholders with actual values
printf $file_handle $source_code, 10, 39, $counter, $source_code;

# Close the file handle
close($file_handle);

# Set an environment variable to indicate this is a child process
$ENV{CHILD_PROCESS} = "CHILD_PROCESS";

# If the counter is not zero, execute the newly created script
if ($counter) {
	system("./Sully_$counter.pl");
}