package EnsEMBL::ORM::Rose::Object::Changelog;

### NAME: EnsEMBL::ORM::Rose::Object::Changelog
### ORM class for the changelog table in ensembl_production 

### STATUS: Stable

use strict;
use warnings;

use base qw(EnsEMBL::ORM::Rose::Object::Trackable);

use constant {
  ROSE_DB_NAME  => 'production',
  TITLE_COLUMN  => 'title',
};

## Define schema
__PACKAGE__->meta_setup(
  table       => 'changelog',

  columns     => [
    changelog_id      => {type => 'serial', primary_key => 1, not_null => 1}, 
    release_id        => {type => 'integer'},
    title             => {type => 'varchar'},
    content           => {type => 'text'},
    notes             => {type => 'text'},
    status            => {type => 'enum', 'values' => [qw(declared handed_over postponed cancelled)]},
    team              => {type => 'enum', 'values' => [qw(Compara Core Funcgen EnsemblGenomes Genebuild Mart Outreach Variation Web Wormbase)]},
    assembly          => {type => 'enum', 'values' => [qw(N Y)]},
    gene_set          => {type => 'enum', 'values' => [qw(N Y)]},
    repeat_masking    => {type => 'enum', 'values' => [qw(N Y)]},
    stable_id_mapping => {type => 'enum', 'values' => [qw(N Y)]},
    affy_mapping      => {type => 'enum', 'values' => [qw(N Y)]},
    biomart_affected  => {type => 'enum', 'values' => [qw(N Y)]},
    db_status         => {type => 'enum', 'values' => [qw(N/A unchanged patched new)]},
  ],

  relationships => [
    species => {
      'type'        => 'many to many',
      'map_class'   => 'EnsEMBL::ORM::Rose::Object::ChangelogSpecies',
      'map_from'    => 'changelog',
      'map_to'      => 'species'
    }
  ]
);

1;