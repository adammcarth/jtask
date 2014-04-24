# JTask ( [![Gem Version](http://img.shields.io/gem/v/jtask.svg)](https://rubygems.org/gems/jtask) [![Build Status](https://travis-ci.org/adammcarthur/jtask.svg?branch=master)](https://travis-ci.org/adammcarthur/jtask) [![Code Climate](http://img.shields.io/codeclimate/github/adammcarthur/jtask.svg)](https://codeclimate.com/github/adammcarthur/jtask) [![Inline docs](http://inch-pages.github.io/github/adammcarthur/jtask.svg)](http://inch-pages.github.io/github/adammcarthur/jtask) ).save

JTask provides CRUD actions for storage of data in JSON format inside text files. It's very useful for times when databases cannot be used to store data, or a simple storage & retrieval mechanism is required. It can act just like a database, check it out:

``` ruby
require "jtask"

JTask.save("preferences.json", {background_color: "black", font_size: "medium"})
#=> true

JTask.get("preferences.json", last: 1).font_size
#=> "medium"
```

The above example stores the settings in a file called `preferences.json`. We then get the last object saved to the file and output the value of the `"font_size"` key. JTask syntax is designed to be simple and elegant to use, making it easy to remember and enjoyable to work with. It even has it's own built in error handler:

``` bash
JTask.get("clients.json", :all)
#=> NameError: [JTask] Couldn't find the file specified at 'models/clients.json'. Try running JTask.save("clients.json") to setup a blank file.
```

The above error makes mention of an id number. As central to many CRUD frameworks, JTask operates around id numbers to manipulate the objects. JTask automatically calculates and assigns these sequential id numbers for you.

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
require "jtask"

# Tell JTask where your files are [optional]
JTask.configure do |config|
  config.file_dir = "path/to/jtask_files/"
end
```

## Basic Documentation

Below you will find a very broad overview of how to use the most common JTask methods. Make sure you [check out the wiki](https://github.com/adammcarthur/jtask/wiki) for the full documentation and implementation examples.

---

#### [JTask.save(filename, parameters, dir)](https://github.com/adammcarthur/jtask/wiki/JTask.save() "View full guide")
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

---

#### [JTask.get(filename, method, dir)](https://github.com/adammcarthur/jtask/wiki/JTask.get() "View full guide")
*Retrieves stored JSON data from the file and returns an OpenStruct.*

``` ruby
JTask.get("email_subscribers.json")
#=> [ #<JTask::Get "id"=1 "email"="gary@google.com">, #<JTask::Get "id"=2 "email"="blah"> ... ]
```

As seen above - calling JTask.get() without a method argument will return **all** the records stored. Let's now try and get the 50th email subscriber's email address:

``` ruby
@subscriber = JTask.get("email_subscribers.json", 50)
#=> #<JTask::Get "id"="50" "email"="yukihiro@matsumoto.net">

@subscriber.email
#=> "yukihiro@matsumoto.net"
```

JTask also comes with a few retrieval methods similar to Active Record. Let's get the **first and last** `n` email subscribers:

``` ruby
JTask.get("email_subscribers.json", first: 25)
#=> [ #<JTask::Get "id"=1>, #<JTask::Get "id"=2>, ..., #<JTask::Get "id"=25> ]

JTask.get("email_subscribers.json", last: 1)
#=> #<JTask::Get "id"=365 "email"="goo@goo.gl">
```

---

#### [JTask.update(filename, id, parameters, dir)](https://github.com/adammcarthur/jtask/wiki/JTask.update() "View full guide")
*Updates an existing JSON object with a new set of values.*

``` ruby
JTask.update("ui_settings.json", 42, {show_ads: "no", background: "grey"})
```

JTask upgrades records gracefully - parameters already existing inside the JSON object will be replaced with the new value, whereas new parameters will be added.

``` ruby
# Original Version
#<JTask::Get "id"=42 "show_ads"="yes">

# Updated Version
#<JTask::Get "id"=42 "show_ads"="no" "background"="grey">
```

To completely remove parameters (the entire key-value pair) from objects, refer to the JTask.chop() method below.

---

#### [JTask.destroy(filename, id, dir)](https://github.com/adammcarthur/jtask/wiki/JTask.destroy() "View full guide")
*Removes an entire object from the file.*

---

#### [JTask.chop(filename, id, paramter, dir)](https://github.com/adammcarthur/jtask/wiki/JTask.chop() "View full guide")
*Removes an entire key-value pair from one or all of the file's objects.*

---

#### [JTask.rename(filename, new, dir)](https://github.com/adammcarthur/jtask/wiki/JTask.rename() "View full guide")
*Simply renames the file to something different.*

---

#### [JTask.kill(filename, dir)](https://github.com/adammcarthur/jtask/wiki/JTask.kill() "View full guide")
*Completely removes the entire file specified from the system.*

---

## Share your ideas and contribute

I'd love to here what you plan to use JTask for. [Let me know via twitter](https://twitter.com/adammcarth), or email your thoughts and ideas to [adam@adammcarthur.net](mailto:adam@adammcarthur.net).

**My favourite feedback so far:**

> "JTask is probably useful."

To contribute to the project, fork it (also create a new feature branch if your changes are substantial), send a pull request and I'll review your changes. Check out the [enhancement suggestions page](https://github.com/adammcarthur/jtask/issues?labels=enhancement) to see what still needs to be done.

\- Adam
