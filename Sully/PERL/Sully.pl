#!/bin/perl

$source_code = '#!/bin/perl%1$c%1$c$source_code = %2$c%4$s%2$c;%1$c%1$c$counter = %3$d;%1$cif ($counter <= 0) {%1$c    exit;%1$c} elsif ($ENV{CHILD_PROCESS}) {%1$c    $counter--;%1$c}%1$c$script_name = "Sully_$counter.pl";%1$copen(my $file_handle, ">$script_name") or exit;%1$cchmod 0755, $script_name;%1$cprintf $file_handle $source_code, 10, 39, $counter, $source_code;%1$cclose($file_handle);%1$c$ENV{CHILD_PROCESS} = "CHILD_PROCESS";%1$cif ($counter) {%1$c    system("./Sully_$counter.pl");%1$c}%1$c';

$counter = 5;
if ($counter <= 0) {
	exit;
} elsif ($ENV{CHILD_PROCESS}) {
	$counter--;
}
$script_name = "Sully_$counter.pl";
open(my $file_handle, ">$script_name") or exit;
chmod 0755, $script_name;
printf $file_handle $source_code, 10, 39, $counter, $source_code;
close($file_handle);
$ENV{CHILD_PROCESS} = "CHILD_PROCESS";
if ($counter) {
	system("./Sully_$counter.pl");
}