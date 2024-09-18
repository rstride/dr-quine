#!/bin/perl

=begin
	There is no such things as macro/define in perl.
	Subroutine could be the most similar to function and/or macro.
=cut
sub ft {$filename = "Grace_kid.pl"; open(FILE, ">$filename") or return; chmod 0755, $filename; printf FILE another_sub(), 10, 39, another_sub(); close(FILE);}
sub code {return '#!/bin/perl%1$c%1$c=begin%1$c	There is no such things as macro/define in perl.%1$c	Subroutine could be the most similar to function and/or macro.%1$c=cut%1$csub ft {$filename = "Grace_kid.pl"; open(FILE, ">$filename") or return; chmod 0755, $filename; printf FILE another_sub(), 10, 39, another_sub(); close(FILE);}%1$csub code {return %2$c%3$s%2$c}%1$csub another_sub {return code}%1$c%1$cft(xxx)%1$c'}
sub another_sub {return code}

ft(xxx)