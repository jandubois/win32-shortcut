use strict;
use warnings;
use Test::More tests => 8;
use Win32::Shortcut;
use File::Temp qw( tempdir );

my $dir = tempdir( CLEANUP => 1 );

my $lnk1 = Win32::Shortcut->new;
isa_ok $lnk1, 'Win32::Shortcut';

$lnk1->{Path} = "C:\\Directory\\Target.exe";
is $lnk1->Path, "C:\\Directory\\Target.exe", 'Path as method';

$lnk1->{Description} = "Target executable";
is $lnk1->Description, "Target executable", 'Description as method';

$lnk1->Save("$dir/Target.lnk");
$lnk1->Close;
ok -e "$dir/Target.lnk", 'link created';

my $lnk2 = Win32::Shortcut->new;
$lnk2->Load("$dir/Target.lnk");

is $lnk2->{Path}, "C:\\Directory\\Target.exe", 'hash get Path';
is $lnk2->Path, "C:\\Directory\\Target.exe", 'method get Path';
is $lnk2->{Description}, "Target executable", 'hash get Description';
is $lnk2->Description, "Target executable", 'method get Description';
