###########################################################################
# ` JTask v0.3.0 Beta                                                   ` #
# ` Provides CRUD actions for JSON files, plus a few extra goodies.     ` #
# ` Created by Adam McArthur (@adammcarth)                              ` #
# ` Released under the MIT licence                                      ` #
# ` Contribute & Documentation: https://github.com/adammcarthur/jtask   ` #
###########################################################################

class JTask
  # Dependencies
  require "rubygems"
  require "ostruct"
  require "json"

  # Configuration
  require "jtask/config"

  # Helpers
  require "jtask/helpers"

  # Tasks
  tasks = ["save", "get", "update", "destroy", "chop", "rename", "kill", "convert"]
  tasks.each do |task|
    require "jtask/#{task}"
  end
end