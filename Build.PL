
use strict;
use warnings;

use Module::Build 0.3601;

my %module_build_args = (
                       'dist_abstract' => 'Dump data structure compactly and potentially partially',
                       'script_files' => [],
                       'license' => 'perl',
                       'build_requires' => {
                                             'Module::Build' => '0.3601'
                                           },
                       'dist_name' => 'Data-Dump-Partial',
                       'dist_author' => [
                                          'Steven Haryanto <stevenharyanto@gmail.com>'
                                        ],
                       'module_name' => 'Data::Dump::Partial',
                       'requires' => {
                                       'perl' => '5.010',
                                       'Data::Dump' => '1.17'
                                     },
                       'recommends' => {},
                       'configure_requires' => {
                                                 'Module::Build' => '0.3601'
                                               },
                       'dist_version' => '0.01'
                     );


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
