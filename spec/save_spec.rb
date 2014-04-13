require "spec_helper"
require "jtask/save"

describe JTask do
  it "saves in a new file" do
    JTask.save("test.json", {name: "John Doe", email: "john@doe.org.au", age: 57, location: {city: "Melbourne", postcode: "3053"}})
  end

  it "saves to an existing file" do
    10.times do
      JTask.save("test.json", {name: "John Doe", email: "john@doe.org.au", age: 57, location: {city: "Melbourne", postcode: "3053"}})
    end
  end

  it "saves using a custom directory" do
    JTask.save("test.json", {name: "John Doe", email: "john@doe.org.au", age: 57, location: {city: "Melbourne", postcode: "3053"}}, "spec/test_files")
  end

  it "can't save when the directory doesn't exist" do
    expect{JTask.save("test.json", {name: "John Doe"}, "spec/this_path_should_fail")}.to raise_error(RuntimeError)
  end

  it "can't save when invalid save parameters are used" do
    expect{JTask.save("test.json", "string")}.to raise_error(SyntaxError)
    expect{JTask.save("test.json", 16611555)}.to raise_error(SyntaxError)
    expect{JTask.save("test.json", :symbolz)}.to raise_error(SyntaxError)
  end

  it "should clear the history using hard coded ruby" do
    # Clear the history
    File.delete("spec/test_files/test.json") if File.exists?("spec/test_files/test.json")
  end
end