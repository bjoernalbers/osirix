# osirix cookbook

Chef cookbook to install [OsiriX](http://www.osirix-viewer.com) on Mac OS X.

# Requirements

Platform: Mac OS X

# Usage

Build a custom dmg package
(try [wrapp](https://github.com/bjoernalbers/wrapp) or `hdiutil`)
from an already installed OsiriX and host it somewhere on your intranet via HTTP.
Then use chef to install the package (Hint: you need to have `osirix` in
your run list and provide some attributes).

# Attributes

Take a peek at `attributes/default.rb`.

# Recipes

Just the default recipe.

# Copyright

Copyright (c) 2013 Björn Albers (<bjoernalbers@googlemail.com>)
