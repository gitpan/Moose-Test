#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use Path::Class;

use Test::More tests => 16;
use Test::Exception;

BEGIN {
    use_ok('Moose::Test');
    use_ok('Moose::Test::Case');
}

my $test_case = Moose::Test::Case->new(
    test_dir   => Path::Class::Dir->new($FindBin::Bin, '002_basic_defaults'),
);
isa_ok($test_case, 'Moose::Test::Case');

isa_ok($test_case->test_dir, 'Path::Class::Dir');

is_deeply($test_case->pm_files, ['001_Foo.pm', '002_Bar.pm'], '... got the right pm files');
is_deeply($test_case->test_files, ['001_test_Foo.pl', '002_test_Bar.pl'], '... got the right test files');

lives_ok {
    $test_case->load_pm_files;
} '... loaded the PM files okay';

my @test_files = $test_case->prepare_test_files;
is(@test_files, 2, '.. got the right number of test files');

do $_ for @test_files;




