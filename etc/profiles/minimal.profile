[profile]
name=minimal
mode=minimal
strict=true

[build]
parallel=false
jobs=1
optimize=true
strip=true
debug=false
reproducible=true

[validation]
lint=false
checksum=false
signature=false
fail_on_warn=false

[runtime]
sandbox=true
fakeroot=false
network=false
timeout=0

[filesystem]
enforce_permissions=true
apply_defaults=true
immutable_system=true

[logging]
level=error
trace=false
persist=false

[security]
policy=enforced
audit=false
fail_on_violation=true

[hooks]
enable=false
strict=true
timeout=0

[cleanup]
auto=true
purge_cache=true
purge_stage=true
purge_tmp=true
