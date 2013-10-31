# Remote file source of OsiriX DMG file, i.e. 'http://example.com/osirix.dmg'
default[:osirix][:source] = ''

# SHA-1 chechsum of DMG file.
default[:osirix][:checksum] = nil

# Destination where OsiriX gets installed (default is '/Applications').
default[:osirix][:destination] = nil
