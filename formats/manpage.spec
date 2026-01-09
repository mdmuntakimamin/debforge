FORMAT_VERSION=1.0
TYPE=manpage

SECTION page
  name        string required
  section     enum(1,5,8) required
  title       string required
  date        string optional
  source      string optional
  manual      string optional
END

SECTION synopsis
  usage       string required
END

SECTION description
  body        text required
END

SECTION options
  option      map optional
END

SECTION commands
  command     map optional
END

SECTION files
  path        list optional
END

SECTION environment
  variable    map optional
END

SECTION exit_status
  code        map optional
END

SECTION authors
  author      list required
END

SECTION license
  text        string optional
END

RULE name MUST_MATCH ^[a-z0-9\-]+$
RULE section MUST_BE_INTEGER
RULE body MUST_NOT_BE_EMPTY
RULE author MUST_NOT_BE_EMPTY
