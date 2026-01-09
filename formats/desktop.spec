FORMAT_VERSION=1.0
TYPE=desktop-entry

SECTION desktop
  name            string required
  generic_name    string optional
  comment         string optional
  exec            path required
  icon            path optional
  terminal        boolean default=false
  type            enum(Application)
  categories      list required
  mime_types      list optional
  startup_notify  boolean default=false
END

SECTION localization
  locale          string optional
  name_localized  map optional
  comment_localized map optional
END

SECTION visibility
  hidden          boolean default=false
  no_display      boolean default=false
  only_show_in    list optional
  not_show_in     list optional
END

SECTION permissions
  requires_root   boolean default=false
  sandbox         boolean default=true
END

RULE name MUST_MATCH ^[A-Za-z0-9 _-]+$
RULE exec MUST_EXIST
RULE categories MUST_CONTAIN Application
RULE type MUST_EQUAL Application
