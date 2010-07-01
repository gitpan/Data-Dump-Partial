
use strict;
use warnings;

use Module::Build 0.3601;

my %module_build_args = (
  'build_requires' => {
    'Module::Build' => '0.3601'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Dump data structure compactly and potentially partially',
  'dist_author' => [
    'Steven Haryanto <stevenharyanto@gmail.com>'
  ],
  'dist_name' => 'Data-Dump-Partial',
  'dist_version' => '0.02',
  'license' => 'perl',
  'module_name' => 'Data::Dump::Partial',
  'recommends' => {},
  'requires' => {
    'Data::Dump' => '1.17',
    'perl' => '5.010'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
