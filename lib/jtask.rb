###########################################################################
# ` JTask v0.0.1 Beta                                                   ` #
# ` Provides CRUD actions for JSON files, plus a few extra goodies.     ` #
# ` Created by Adam McArthur (@adammcarth)                              ` #
# ` Released under the MIT licence                                      ` #
# ` Contribute & Documentation: https://github.com/adammcarthur/jtask   ` #
###########################################################################

class JTask
  # Dependencies
  require "rubygems"
  require "json"

  # Modules
  require "jtask/get"
  require "jtask/save"
  require "jtask/update"
  require "jtask/destroy"
  require "jtask/chop"
  require "jtask/rename"
  require "jtask/kill"
  extend Save
  extend Get
  extend Update
  extend Destroy
  extend Chop
  extend Rename
  extend Kill
end