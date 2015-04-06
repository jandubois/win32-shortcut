#!perl

#Create shortcut on desktop for cpan client
use strict;
use warnings;
use Win32::Shortcut;
use File::Which;
use File::HomeDir;
my $cpan = which('cpan.bat') or die "Cannot find cpan.bat location";
print "cpan.bat: $cpan\n";
my $desktop = File::HomeDir->my_desktop;
print "Desktop: $desktop\n";

my $l = Win32::Shortcut->new;
$l->{'Path'} = $cpan;
$l->{'Description'} = "cpan client";
$l->ShowCmd(SW_SHOWNORMAL);

my $perl_dir = $^X;
if ($perl_dir =~ s/perl\\bin\\perl\.exe$//i) {
  my $ico = "$perl_dir\\win32\\cpan.ico"; #icon in Strawberry perl
  if (-e $ico) {
    print "icon $ico found\n";
    $l->{'IconLocation'} = $ico;
  }
}

$l->Save("$desktop\\cpan client.lnk");
$l->Close();
