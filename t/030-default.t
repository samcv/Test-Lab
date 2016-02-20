use v6;
use Test;
use lib 'lib';

use Test::Lab::Experiment;

sub it($behavior, &block) {
  my Test::Lab::Experiment::Default $*ex .= new;
  subtest &block, $behavior;
}

it 'is always enabled', {
  ok $*ex.is-enabled;
}

it 'noops publish', {
  is $*ex.publish('data'), Nil;
}

it 'is an experiment', {
  isa-ok $*ex, Test::Lab::Experiment::Default;
  isa-ok Test::Lab::Experiment::Default, Test::Lab::Experiment;
}

it 'rethrows when an internal action throws', {
  throws-like {
    $*ex.died('publish', die 'kaboom')
  }, Exception;
}

done-testing;
