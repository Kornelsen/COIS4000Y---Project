#!usr/bin/perl

#Capture course text [»]\s(.*)[»]
#Capture Prequisites: \bPrerequisite\b(.*)[./s]
#Capture Course code: [A-Z]{4}\s[0-9]{4}
#Capture within PreReq: qr/([A-Z]{4}\s[0-9]{4}(H|Y){1}\s(and)\s[0-9]{4}(H|Y){1}|[A-Z]{4}\s[0-9]{4}(H|Y){1}\s(or)\s[0-9]{4}(H|Y){1})/sp;
#Capture # of credits within prereq: qr/[0-9]{1,2}[\.](.*)(credits){1}/p;

use warnings; use strict;

my $input_file = "Calendar.txt";

open my $fh, '<', $input_file or die "Could not open file";

my $file_content = do { local $/; <$fh> };

my @courses = ($file_content =~ /COURSE>\s+(.+?)</sg);

my $regex = qr/[A-Z]{4}\s[0-9]{4}(H|Y){1}/p;
my $regex2 = qr/\bPrerequisite\b(.*)[.]/sp;
#my $regex3 = qr/([A-Z]{4}\s[0-9]{4}(H|Y){1}\s(and)\s[0-9]{4}(H|Y){1}|[A-Z]{4}\s[0-9]{4}(H|Y){1}\s(or)\s[0-9]{4}(H|Y){1})/sp;
my $regex3 = qr/.+?(?=\sor)/p;
my $regex4= qr/\sor\s.*/p;
my $regex5 = qr/[0-9]{1,2}[\.](.*)(university){1}/p; #Total required credits
my $regex6 = qr/[0-9]{2}(%)\s(average)/p; #Average for course
my $regex7 = qr/[0-9]{1,2}[\.]{1}[0-9]{1}\s(additional)\s(credits)\s(at)\s(the)\s[0-9]{4}/p; #Additional Credits at xxxx Level

my $filename = 'results.xml';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "<?xml version=\"1.0\" ?>";
print $fh "<START>\n";

#my $counter = 0;


for (my $i = 0; $i < @courses; $i++) {

    if ( $courses[$i] =~ /$regex/ ) {
  		print $fh "<COURSE>";

  		print $fh "<CCODE> ${^MATCH} </CCODE>";
  		my $ccode = ${^MATCH};
  		
  	if ( $courses[$i] =~ /$regex2/ ) {
  		my $PreReq = "${^MATCH}";
  		$PreReq =~ s/\&/and/ig;
  		$PreReq =~ s/Prerequisite://ig;
  		$PreReq =~ s/or permission of//ig;
  		$PreReq =~ s/instructor.//ig;
  		print $fh "<PRE>$PreReq</PRE>";

  		if ($PreReq =~ /$regex3/g) {
  				print $fh "<REQ> ${^MATCH} </REQ>";
  				code_assoc(${^MATCH}, $ccode);

			if ($PreReq =~ /$regex4/g) {
  				print $fh "<ALTREQ> ${^MATCH} </ALTREQ>";
  				code_assoc(${^MATCH}, $ccode);
			}
		}
		else {

		}

  		if ($PreReq =~ /$regex5/g) {
  				print $fh "<CREDITS> ${^MATCH} </CREDITS>";
			}
		if ($PreReq =~ /$regex6/g) {
  				print $fh "<AVERAGE> ${^MATCH} </AVERAGE>";
			}
		if ($PreReq =~ /$regex7/g) {
  				print $fh "<ADDITIONAL> ${^MATCH} </ADDITIONAL>";
			}

  		}

  	print $fh "</COURSE>";

  	  	}
}
print $fh "</START>";
close $fh;

sub code_assoc {

	my ($target, $x) = @_;

	my @matrix;

	my $regex = qr/[A-Z]{4}-?(\s|[A-Z]{4})/p;
	my $regex2 = qr/[0-9]{4}[YH]{1}/p;

	my @ccodes = ($target =~ /$regex/g);

	my $arrSize = @ccodes;

	for (my $i = 0; $i < @ccodes; $i++) {
		if (length($ccodes[$i]) > 3) {
			#print "TARGET: \t$target\n";
			my $n = index($target, $ccodes[$i]);
			#print "FOUND AT $n\n";
			my $nth = substr($target, $n, 4);
			$matrix[$i][0] = $nth;
			#print "FOUND THIS: \t$matrix[$i][0]\n";

			my $subTarget = substr($target,$n);

			my @subCodes = ($subTarget =~ /$regex2/g);

			print "$x REQUIRES: $matrix[$i][0]";

			for (my $j = 0; $j < @subCodes; $j++) {
				#print "CODE FOUND: $subCodes[$j]\n";
				$matrix[$i][$j] = $subCodes[$j];
				print " $matrix[$i][$j]"
			}

			print "\n";

		}
	}	

	return @matrix;
}
