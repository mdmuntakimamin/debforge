FORMAT_VERSION=1.0

SECTION project
  name        string required
  id          string required
  version     semver required
  description string optional
  license     string optional
  homepage    url optional
  maintainer  string required
END

SECTION source
  type        enum(local,git,archive)
  path        string required
  branch      string optional
  commit      string optional
END

SECTION build
  system      enum(make,cmake,meson,custom)
  arch        enum(all,amd64,arm64,armhf,i386)
  flags       string optional
  parallel    boolean default=true
  strip       boolean default=true
END

SECTION runtime
  entry       path required
  args        string optional
  env         map optional
END

SECTION filesystem
  prefix      path default=/usr
  bindir      path default=/usr/bin
  libdir      path default=/usr/lib
  sharedir    path default=/usr/share
  confdir     path default=/etc
END

SECTION dependencies
  build_dep   list optional
  run_dep     list optional
  conflict    list optional
  replace    list optional
END

SECTION scripts
  preinst     path optional
  postinst    path optional
  prerm       path optional
  postrm     path optional
END

SECTION validation
  lint        boolean default=true
  checksum    boolean default=true
  signature   boolean default=false
END

RULE version MUST_MATCH ^[0-9]+\.[0-9]+\.[0-9]+$
RULE name MUST_MATCH ^[a-z0-9][a-z0-9\-]+$
RULE id MUST_MATCH ^[a-z][a-z0-9_]+$
