[profile]
name=developer
mode=development
strict=false

[build]
parallel=true
jobs=auto
optimize=false
strip=false
debug=true
reproducible=false

[validation]
lint=true
checksum=true
signature=false
fail_on_warn=false

[runtime]
sandbox=false
fakeroot=true
network=true
timeout=0

[filesystem]
enforce_permissions=false
apply_defaults=true
immutable_system=false

[logging]
level=debug
trace=true
persist=true

[security]
policy=permissive
audit=true
fail_on_violation=false

[hooks]
enable=true
strict=false
timeout=0

[cleanup]
auto=false
purge_cache=false
purge_stage=false
purge_tmp=false
