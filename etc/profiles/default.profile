[profile]
name=default
mode=balanced
strict=true

[build]
parallel=true
jobs=auto
optimize=true
strip=true
debug=false
reproducible=true

[validation]
lint=true
checksum=true
signature=false
fail_on_warn=false

[runtime]
sandbox=true
fakeroot=true
network=false
timeout=0

[filesystem]
enforce_permissions=true
apply_defaults=true
immutable_system=true

[logging]
level=info
trace=false
persist=true

[security]
policy=enforced
audit=true
fail_on_violation=true

[hooks]
enable=true
strict=true
timeout=30

[cleanup]
auto=true
purge_cache=false
purge_stage=true
purge_tmp=true
