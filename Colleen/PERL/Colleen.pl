#!/bin/perl

=begin
	This is a comment
=cut
sub f{
	$code = '#!/bin/perl%1$c%1$c=begin%1$c	This is a comment%1$c=cut%1$csub f{%1$c	$code = %2$c%3$s%2$c;%1$c	printf $code, 10, 39, $code%1$c}%1$c%1$csub main {%1$c=begin%1$c	This is another comment%1$c=cut%1$c	f();%1$c}%1$c%1$cmain();%1$c';
	printf $code, 10, 39, $code
}

sub main {
=begin
	This is another comment
=cut
	f();
}

main();