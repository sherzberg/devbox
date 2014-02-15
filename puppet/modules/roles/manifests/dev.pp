class roles::dev {

  include docker

  package {'base-deps':
    ensure => present,
    name   => ['vim', 'git', 'subversion', 'mercurial', 'cowsay'],
  }

  package {'python-pip':
    ensure => present,
  }

  package {'pip':
    ensure   => latest,
    provider => pip,
    require  => [Package['python-pip']],
  }

  package {'python-deps':
    ensure   => latest,
    name     => ['fig', 'pss', 'autoenv', 'virtualenvwrapper', 'virtualenv'],
    provider => pip,
    require  => [Package['pip']],
  }

}
