#!/usr/bin/perl

#### TODO: add switch statement to turn course department into abbreviated version

use strict;
use warnings;
use CAM::PDF;

my $filename = "uploads/";

my $num_args = $#ARGV + 1;

if ($num_args > 0) {
	$filename .= $ARGV[0];
}	
else {
	print "No arguements present\n";
	exit;
}

my $transcript = convert_pdf_to_text($filename);

my $replace1 = qr/\&/p;
my $replace2 = qr/20\d{2}(-20\d{2})*\s(Academic\sYear|Summer\sSession)/p;
my $replace3 = qr/\b[ABCDF]{1}(\s|\+|\-)/p;

$transcript =~ s/$replace1/and/g;
$transcript =~ s/$replace2//ig;
$transcript =~ s/$replace3/\n/ig;

my $regex = qr/[A-Z]{1}(\w|\s)+\d{4}(Y|H){1}:{1}(\w|\s)+\d.\d\s+(\d{2}|INP)/p;

my $mnum = () = ($transcript =~ /$regex/g);

my $jarray = "{\n";

$jarray .= "\"Credits\": [\n";

my $counter = 1;

while ( $transcript =~ /$regex/g ) {
  	my $temp = ${^MATCH};
  	$jarray .= "{\n";
	$jarray = course_info($temp, $jarray);
	if ($counter == $mnum/4) {
		$jarray .= "}\n";
	}
	else {
		$jarray .= "\n},\n";
	}
	$counter = $counter + 1;
}

$jarray .= "]\n";
$jarray .= "}\n";

	print "$jarray\n";

sub convert_pdf_to_text {
    use CAM::PDF::PageText;
    my ($pdf_filename) = @_;
    my $pdf = CAM::PDF->new($pdf_filename);
    my $y   = $pdf->getPageContentTree(1);
    my $transcript = CAM::PDF::PageText->render($y);
    return $transcript;
}

sub course_info {
	my ($course, $jarray) = @_;

	my $replace1 = qr/\s{2,}/p;
	my $replace2 = qr/\s\d{4}(Y|H)/p;

	my $regex1 = qr/([A-Za-z]|\s)+\d{4}(H|Y)/p;
	my $regex2 = qr/\d{4}(Y|H)/p;
	my $regex3 = qr/\d\.\d/p;
	my $regex4 = qr/\d{2}\b/p;
	my $regex5 = qr/(INP)/p;

	my $cnum;

	$course =~ s/$replace1/ /ig;

	if ( $course =~ /$regex1/g ) {

		my $ccode = ${^MATCH};

		if ( $ccode =~ /$regex2/g ) {
			$cnum = ${^MATCH};
  			$ccode =~ s/$replace2//ig;
  			$jarray .= "\"DEPT\": \"$ccode\",\n";
  			$jarray .= "\"CODE\": \"$cnum\",\n";
		}
	}

	if ($course =~ /$regex3/g ){
		$jarray .= "\"CREDS\": \"${^MATCH}\",\n";
	}

	if ($course =~ /$regex4/g ){
		$jarray .= "\"GRADE\": \"${^MATCH}\"\n";
	}
	elsif ($course =~ /$regex5/g ){
		$jarray .= "\"GRADE\": \"${^MATCH}\"\n";
	}
}