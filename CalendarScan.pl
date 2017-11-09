#!usr/bin/perl

#Capture course text [»]\s(.*)[»]
#Capture Prequisites: \bPrerequisite\b(.*)[./s]
#Capture Course code: [A-Z]{4}\s[0-9]{4}

my $input_file = "Calendar.txt";

open my $fh, '<', $input_file or die "Could not open file";

my $file_content = do { local $/; <$fh> };

my @courses = ($file_content =~ /COURSE>\s+(.+?)</sg);

my $regex = qr/[A-Z]{4}\s[0-9]{4}(H|Y){1}/p;
my $regex2 = qr/\bPrerequisite\b(.*)[.]/sp;


for (my $i = 0; $i < @courses; $i++) {

    if ( $courses[$i] =~ /$regex/ ) {
  		print "<COURSE> ${^MATCH}\n";
  	}

  	if ( $courses[$i] =~ /$regex2/ ) {
  		print "\t<PREREQ> ${^MATCH} </PREREQ>\n\n";
  	}

  	print "</COURSE>\n\n"
}




