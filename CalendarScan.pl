#!usr/bin/perl

#Capture course text [»]\s(.*)[»]
#Capture Prequisites: \bPrerequisite\b(.*)[./s]
#Capture Course code: [A-Z]{4}\s[0-9]{4}
#Capture within PreReq: qr/([A-Z]{4}\s[0-9]{4}(H|Y){1}\s(and)\s[0-9]{4}(H|Y){1}|[A-Z]{4}\s[0-9]{4}(H|Y){1}\s(or)\s[0-9]{4}(H|Y){1})/sp;
#Capture # of credits within prereq: qr/[0-9]{1,2}[\.](.*)(credits){1}/p;

use warnings; use strict;
use Getopt::Long;

my $input_file = "Calendar.txt";

open my $fh, '<', $input_file or die "Could not open file";

my $file_content = do { local $/; <$fh> };

my @courses = ($file_content =~ /COURSE>\s+(.+?)</sg);

my $regex = qr/[A-Z]{4}\s[0-9]{4}(H|Y){1}/p;
my $regex2 = qr/\bPrerequisite\b(.*)[.]/sp;
#my $regex3 = qr/([A-Z]{4}\s[0-9]{4}(H|Y){1}\s(and)\s[0-9]{4}(H|Y){1}|[A-Z]{4}\s[0-9]{4}(H|Y){1}\s(or)\s[0-9]{4}(H|Y){1})/sp;
#my $regex3 = qr/.+?(?=\sor)/p;
#my $regex4= qr/\sor\s.*/p;
my $regex3 = qr/[A-Z]{4}\s[0-9]{4}[HY]{1}(.*)[0-9]{4}[HY]{1}/p;
my $regex6 = qr/[0-9]{2}(%)\s(average)/p; #Average for course
my $regex7 = qr/[0-9]{1,2}[\.]{1}[0-9]{1}\s(additional)\s(credits)\s(at)\s(the)\s[0-9]{4}/p; #Additional Credits at xxxx Level
my $regex8 = qr/[A-Z]{4}(.*)[0-9]{4}[YH]/p; #Trim down Prequisite section

my $filename = 'results.xml';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "<?xml version=\"1.0\" ?>";
print $fh "<CATALOG>\n";

#my $counter = 0;

my $PreReqTrim = "";


for (my $i = 0; $i < @courses; $i++) {

    if ( $courses[$i] =~ /$regex/ ) {
  		print $fh "<COURSE>";

  		print $fh "<CCODE> ${^MATCH} </CCODE>";
  		my $ccode = ${^MATCH};
  		
  	if ( $courses[$i] =~ /$regex2/ ) {
  		print $fh "<PREREQUISITE>";
  		my $RegPre = qr/(Excludes)(.*)(\.)/p;
  		my $PreReq = "${^MATCH}";
  		$PreReq =~ s/\&/and/ig;
  		$PreReq =~ s/Prerequisite://ig;
  		$PreReq =~ s/or permission of//ig;
  		$PreReq =~ s/instructor//ig;
  		$PreReq =~ s/$RegPre//ig;
  		#print $fh "<PREREQUISITE> $PreReq </PREREQUISITE>";
  		xLevelCourses($PreReq, $fh);
  		if ($PreReq =~ /$regex8/) {	
			my $PreReqTrim = "${^MATCH}";

			print $fh "<PRE>$PreReqTrim</PRE>";

			if ($PreReqTrim =~ /$regex3/g) {
				#print "MATCH: ${^MATCH}\n";
				code_assoc(${^MATCH}, $fh);
			}

  			#if ($PreReqTrim =~ /$regex3/g) {
  			#	print $fh "<REQ> ${^MATCH} </REQ>";
  			#	code_assoc(${^MATCH}, $fh);
  				#print "<REQ> ${^MATCH} </REQ>\n";

			#if ($PreReq =~ /$regex4/g) {
  			#	print $fh "<ALTREQ> ${^MATCH} </ALTREQ>";
  			#	code_assoc(${^MATCH}, $fh);
  			#	#print "<ALTREQ> ${^MATCH} </ALTREQ>\n";
			#	}
			}

		if ($PreReq =~ /$regex6/g) {
  				print $fh "<AVERAGE> ${^MATCH} </AVERAGE>";
			}
		if ($PreReq =~ /$regex7/g) {
  				print $fh "<ADDITIONAL> ${^MATCH} </ADDITIONAL>";
			}
		print $fh "</PREREQUISITE>";
  		}

  	print $fh "</COURSE>";

  	  	}
}
print $fh "</CATALOG>";
close $fh;

sub code_assoc {

	my ($target, $fh) = @_;

  print "TARGET: $target\n";

	my $length = length($target);

  $target =~ s/\(/\{/ig;
  $target =~ s/\)/\}/ig;

	substr($target,0,0,"(");
	#substr($target, $length, 0, ")");

	$target .= ")";

	my $regex = qr/\sor\s/p;
  my $regex2 = qr/[A-Z]{4}/p;
  my $regex3 = qr/[0-9]{4}[YH]{1}/p;

	if ( $target =~ /$regex/g ) {

  		my $start = $-[0];
  		my $end = $+[0];

  		substr($target,$start,0," ) ");
  		substr($target,$end,0," ( ");
	}

	print "NEW: $target\n";

  $target =~ s/\(/\( /ig;
  $target =~ s/\)/ \)/ig;
  $target =~ s/\{/\{ /ig;

  GetOptions( 'input=s' => \$target );

  my $open = 0;
  my $count = 0;
  my $currentCode = "NULL";
  my $curlyBrace = 0;

  for (split ' ', $target) {
        #printf("word%d = %s\n", ++$count, $_);

        my $word = $_;

        if ($word eq '(') {
          $open++;
          print $fh "<REQCODE>\n";
        }
        if ($_ =~ /$regex2/g) {
          $currentCode = ${^MATCH};
        }
        if ($_ =~ /$regex3/g ) {
          print $fh "CODE: $currentCode ${^MATCH}\n";
          if ($curlyBrace == 1) {
            print $fh "</ALTCODE>\n";
            $curlyBrace = 0;
          }
        }
        if ($word eq ')') {
          $open--;
          print $fh "</REQCODE>\n";
        }
        if ($word eq '{') {
          print $fh "<ALTCODE>\n";
          $curlyBrace = 1;
        }
  }

  print "STATUS: $open\n";

}

sub xLevelCourses {

	my ($target, $fh) = @_;

	my $replace = qr/including(.*)[0-9]{4}[YH]/p;
	my $replace2 = qr/which\sinclude(.*)[0-9]{4}[YH]/p;
	my $regex = qr/[0-9]{1,2}\.(.*)credit(s|)(.*)./p;
	my $regex2 = qr/[0-9]{1,2}[\.](.*)(university){1}/p; #Total required credits
	my $regex3 = qr/[0-9][0]{3}\W(.*)(level)/p;
	my $regex4 = qr/[A-Z]{4}\s/p;
	my $regex5 = qr/[0-9]{1,2}\.[0-9]{1}/p;

	$target =~ s/\R/ /g;
	$target =~ s/$replace//ig;
	$target =~ s/$replace2//ig;

	print $fh "<CREDITS>";

	if ($target =~ /$regex2/g) {
		my $credits = ${^MATCH};
		$credits =~ s/university//ig;
  		print $fh "<TOTAL> $credits </TOTAL>";
	}

	$target =~ s/$regex2//ig;

	if ( $target =~ /$regex/g ) {
		print $fh "<ADDITIONAL>";
		my $including = ${^MATCH};

		print $fh "<TYPE>";

  		my @typeunf = ( $including =~ /$regex4/g);
  		my @type = uniq(@typeunf);

  		for (my $i = 0; $i < @type; $i++) {
  			print $fh "<CODE> $type[$i] </CODE>";
  		}

  		print $fh "</TYPE>";

  		print $fh "<TARGET> $including </TARGET>";

  		if ($including =~ /$regex5/g) {
  			print $fh "<TOTAL> ${^MATCH} </TOTAL>";
  		}

  		if ($including =~ /$regex3/g) {
  			print $fh "<LEVEL> ${^MATCH} </LEVEL>";
  		}

  		print $fh "</ADDITIONAL>";
	}
	print $fh "</CREDITS>";
}

# Get rid of duplicate array items
sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}
