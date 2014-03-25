# JTask [![Gem Version](https://badge.fury.io/rb/jtask.png)](http://badge.fury.io/rb/jtask)

JTask provides CRUD actions for storage of data in JSON format inside text files. It's very useful for times when databases cannot be used to store data, or a simple storage & retrieval mechanism is required. It can act just like a database, check it out:

    require "jtask"

    JTask.save("preferences", {background_color: "black", font_size: "medium"})
    #=> true

    JTask.get("preferences", 1)["font_size"]
    #=> "medium"

The above example stores the settings in a file called `preferences` using JSON. We then get the object from the file with id `1`, and output the value of the `"font_size"` key.

**Example of JTask storage file:**

    {
      "1": {
        "background_colour": "black",
        "font_size": "medium"
      }
    }

Sequential ID's are automatically assigned to JSON objects on save.

### JTask.save(filename, parameters, dir=nil)
*Saves a hash of parameters to the requested file.*

    JTask.save("foods", {entree: "cheese", main: "hamburger", desert: "cake"})

You can use file extensions if you want (makes no difference), as well as set a custom directory for the file. The default directory JTask will look in is `/models`.

    JTask.save("users.json", {username: "adam", twitter: "@adammcarth"}, "files/")

Notes:

 - **JTask will automatically create the files** for you on save if they don't exist.
 - To prepare already existing files for JTask operations, they must only contain `{}` inside.
 - When setting a custom directory, ensure it ends with `/`.

### JTask.get(filename, method=nil, dir=nil)
*Retrieves stored JSON data from the file and returns a hash.*

    JTask.get("email_subscribers")

    #=> [ {"id"=>1, "email"=>"gary@google.com"}, {"id"=>"2", "email"=>"blah"} ... ]

As seen above - calling JTask.get() without a method argument will return **all** the records stored. Let's now try and get the 50th email subscriber's email address:

    @subscriber = JTask.get("email_subscribers", 50)
    #=> {"id"=>"50", "email"=>"yukihiro@matsumoto.net"}

    @subscriber["email"]
    #=> "yukihiro@matsumoto.net"

JTask also comes with a few retrieval methods similar to Active Record. Let's get the **first and last** `n` email subscribers:

    JTask.get("email_subscribers", first: 25)
    #=> [ {"id" => 1, ...}, {"id" => 2, ...}, {"id" => 25, ...} ]

    JTask.get("email_subscribers", last: 1)
    #=> {"id" => 365, "email" => "goo@goo.gl"}

### JTask.update(filename, id, parameters, dir=nil)
*Updates the record with `id` with a new set of parameters.*

    JTask.update("ui_settings", 42, {show_ads: "no", background: "grey"})

JTask upgrades records gracefully - parameters already existing inside the JSON object will be replaced with the new value, whereas new parameters will be added.

    # Original Version
    { "id" => 42, "show_ads" => "yes" }

    # Updated Version
    { "id" => 42, "show_ads" => "no", "background" => "grey" }

To completely remove parameters (the entire key-value pair) from objects, refer to the JTask.chop() method below.

### JTask.destroy(filename, id, dir=nil)
*Removes an entire object from the file.*

    JTask.destroy("twitter_names", 15)

### JTask.chop(filename, id, paramter, dir=nil)
*Removes an entire key-value pair (or parameter) from one or all of the file's objects.*

    JTask.chop("users", 4, "session_data")

    JTask.chop("users", :all, "session_data")

Impact:

    # Old Version
    { "id" => 4, "user_id" => "p18573", "session_data" => "34F3jkdf9azfvVak2" }

    # New Version
    { "id" => 4, "user_id" => "p18573" }

The second example uses `:all` instead of an id. This would perform the same operation, but to all objects inside the target file (instead of a specific id).

### JTask.rename(filename, new, dir=nil)
*Simply renames the file to something different.*

    JTask.rename("orders", "online_orders")

### JTask.kill(filename, dir=nil)
*Completely removes the entire file specified from the system.*

    # Proceed with caution, the will delete the entire
    # file and it cannot be recovered.
    JTask.kill("not_needed_anymore.json")

## Share your ideas and contribute

I'd love to here what you plan to use JTask for. [Let me know via twitter](https://twitter.com/adammcarth), or email your thoughts and ideas to [adam@adammcarthur.net](mailto:adam@adammcarthur.net).

To contribute to the project, fork it, send a pull request and I'll review your changes. Check out the `todo.txt` list to see what still needs to be done.

\- Adam
