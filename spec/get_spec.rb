require "spec_helper"
require "jtask/get"

describe JTask do
  it "should initialize test data using hard coded ruby" do
    FileUtils.cp("spec/test_files/test_data.json", "spec/test_files/test.json")
  end

  it "gets all objects from the file" do
    JTask.get("test.json")
    JTask.get("test.json", :all)
  end

  it "gets the object with id 7" do
    @user = JTask.get("test.json", 7)
    @user.id.should == 7
  end

  it "gets the objects with ids 3, 4 & 10" do
    @users = JTask.get("test.json", [3, 4, 10])
    @users[2].name.should == "Pablo Castillo"
  end

  it "gets the first 5 objects" do
    @users = JTask.get("test.json", first: 5)
    @users[4].email.should == "nicole@philips.us"
  end

  it "gets the last 2 objects" do
    @users = JTask.get("test.json", last: 2)
    @users[0].age.should == 20
  end

  it "gets the name of the object with id 1" do
    @user = JTask.get("test.json", 1)
    @user.name.should == "John Doe"
  end

  it "gets the postcode (deepstruct) of the object with id 6" do
    @user = JTask.get("test.json", 6)
    @user.location.postcode.should == "85700"
  end

  it "gets all records using a custom directory" do
    JTask.get("test.json", :all, "spec/test_files")
  end

  it "should return nil when the specified id doesn't exist" do
    JTask.get("test.json", 1500).should == nil
  end

  it "throws a runtime error when the directory doesn't exist" do
    expect{JTask.get("test.json", :all, "spec/this_path_should_fail")}.to raise_error(RuntimeError)
  end

  it "throws a name error when the file doesn't exist" do
    expect{JTask.get("testzZzZ.json")}.to raise_error(NameError)
  end

  it "throws a syntax error when an invalid get method is used" do
    expect{JTask.get("test.json", "pickme!")}.to raise_error(SyntaxError)
  end

  it "should clear the history using hard coded ruby" do
    # Clear the history
    File.delete("spec/test_files/test.json") if File.exists?("spec/test_files/test.json")
  end
end