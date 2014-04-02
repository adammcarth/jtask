# JTask [![Gem Version](https://badge.fury.io/rb/jtask.png)](http://badge.fury.io/rb/jtask)

JTask provides CRUD actions for storage of data in JSON format inside text files. It's very useful for times when databases cannot be used to store data, or a simple storage & retrieval mechanism is required. It can act just like a database, check it out:

``` ruby
require "jtask"

JTask.save("preferences.json", {background_color: "black", font_size: "medium"})
#=> true

JTask.get("preferences.json", last: 1).font_size
#=> "medium"
```

The above example stores the settings in a file called `preferences` using JSON. We then get the last object saved to the file and output the value of the `"font_size"` key.

**Example of JTask storage file:**

``` json
{
  "1": {
    "background_colour": "black",
    "font_size": "medium"
  }
}
```

JTask can even act as a management system for already exisiting json files. Please note that a few adjustments will need to be made to your files beforehand - check out the [JTask::Convert](https://github.com/adammcarthur/jtask/wiki/JTask::Convert "Configure existing json files for JTask") wiki guide for more information.

## Getting Started
``` bash
gem install jtask
```

``` ruby
# Include the jtask library where necassary
require "jtask"

# Tell JTask where your files are [optional]
JTask.configure do |config|
  config.file_dir = "path/to/jtask_files/"
end
```

### [JTask.save(filename, parameters, dir=nil)](https://github.com/adammcarthur/jtask/wiki/JTask.save() "View full guide")
*Saves a hash of parameters to the requested file.*

``` ruby
JTask.save("foods.json", {entree: "cheese", main: "hamburger", desert: "cake"})
```

Custom directories can be set each time (refer to below). The default directory JTask will look in is `/models`.

``` ruby
JTask.save("users.json", {username: "adam", twitter: "@adammcarth"}, "files/")
```

Notes:

 - **JTask will automatically create the files** for you on save if they don't exist.
 - To prepare already existing files for JTask operations, they must only contain `{}` inside.
 - When setting a custom directory, ensure it ends with `/`.

### [JTask.get(filename, method=nil, dir=nil)](https://github.com/adammcarthur/jtask/wiki/JTask.get() "View full guide")
*Retrieves stored JSON data from the file and returns an OpenStruct.*

``` ruby
JTask.get("email_subscribers.json")
#=> [ <OpenStruct "id"=1 "email"=>"gary@google.com">, <OpenStruct "id"=>2 "email"=>"blah"> ... ]
```

As seen above - calling JTask.get() without a method argument will return **all** the records stored. Let's now try and get the 50th email subscriber's email address:

``` ruby
@subscriber = JTask.get("email_subscribers.json", 50)
#=> <OpenStruct "id"="50" "email"="yukihiro@matsumoto.net">

@subscriber.email
#=> "yukihiro@matsumoto.net"
```

JTask also comes with a few retrieval methods similar to Active Record. Let's get the **first and last** `n` email subscribers:

``` ruby
JTask.get("email_subscribers.json", first: 25)
#=> [ <OpenStruct "id"=1>, <OpenStruct "id"=2>, ..., <OpenStruct "id"=25> ]

JTask.get("email_subscribers.json", last: 1)
#=> <OpenStruct "id"=365 "email"="goo@goo.gl">
```

### [JTask.update(filename, id, parameters, dir=nil)](https://github.com/adammcarthur/jtask/wiki/JTask.update() "View full guide")
*Updates an existing JSON object with a new set of values.*

``` ruby
JTask.update("ui_settings.json", 42, {show_ads: "no", background: "grey"})
```

JTask upgrades records gracefully - parameters already existing inside the JSON object will be replaced with the new value, whereas new parameters will be added.

``` ruby
# Original Version
<OpenStruct "id"=42 "show_ads"="yes">

# Updated Version
<OpenStruct "id"=42 "show_ads"="no" "background"="grey">
```

To completely remove parameters (the entire key-value pair) from objects, refer to the JTask.chop() method below.

### [JTask.destroy(filename, id, dir=nil)](https://github.com/adammcarthur/jtask/wiki/JTask.destroy() "View full guide")
*Removes an entire object from the file.*

``` ruby
JTask.destroy("twitter_names.json", 15)
```

### [JTask.chop(filename, id, paramter, dir=nil)](https://github.com/adammcarthur/jtask/wiki/JTask.chop() "View full guide")
*Removes an entire key-value pair from one or all of the file's objects.*

``` ruby
JTask.chop("users.json", 4, "session_data")

JTask.chop("users.json", :all, "session_data")
```

Impact:

``` ruby
# Old Version
<OpenStruct "id"=4 "user_id"="p18573" "session_data"="34F3jkdf9azfvVak2">

# New Version
<OpenStruct "id"=4 "user_id"="p18573">
```

The second example uses `:all` instead of an id. This would perform the same operation, but to all objects inside the target file (instead of a specific id). [Make sure you read the Chop wiki page](https://github.com/adammcarthur/jtask/wiki/JTask.chop()) to learn more.

### [JTask.rename(filename, new, dir=nil)](https://github.com/adammcarthur/jtask/wiki/JTask.rename() "View full guide")
*Simply renames the file to something different.*

``` ruby
JTask.rename("orders.json", "online_orders.json")
```

### [JTask.kill(filename, dir=nil)](https://github.com/adammcarthur/jtask/wiki/JTask.kill() "View full guide")
*Completely removes the entire file specified from the system.*

``` ruby
# Proceed with caution, the will delete the entire
# file and it cannot be recovered.
JTask.kill("not_needed_anymore.json")
```

## Share your ideas and contribute

I'd love to here what you plan to use JTask for. [Let me know via twitter](https://twitter.com/adammcarth), or email your thoughts and ideas to [adam@adammcarthur.net](mailto:adam@adammcarthur.net).

To contribute to the project, fork it, send a pull request and I'll review your changes. Check out the `todo.txt` list to see what still needs to be done.

\- Adam
