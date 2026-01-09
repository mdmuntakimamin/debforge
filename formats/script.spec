FORMAT_VERSION=1.0
TYPE=script

SECTION script
  name        string required
  stage       enum(preinst,postinst,prerm,postrm,prebuild,postbuild,prerun,postrun)
  interpreter enum(sh,bash) default=bash
  path        path optional
END

SECTION execution
  user        enum(root,package) default=package
  cwd         path optional
  timeout     integer optional
  strict      boolean default=true
END

SECTION environment
  export      map optional
END

SECTION filesystem
  read        list optional
  write       list optional
END

SECTION conditions
  arch        list optional
  distro     list optional
  version     string optional
END

SECTION error_handling
  on_fail     enum(abort,continue,rollback)
  retries     integer default=0
END

RULE name MUST_MATCH ^[a-zA-Z0-9_\-]+$
RULE stage MUST_BE_DEFINED
RULE interpreter MUST_BE_VALID
