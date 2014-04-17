require "spec_helper"
require "jtask/update"
require "jtask/get"

describe JTask do
  it "should initialize test data using hard coded ruby" do
    FileUtils.cp("spec/test_files/test_data.json", "spec/test_files/test.json")
  end

  it "updates an object using a specific id" do
    JTask.update("test.json", 1, age: 58)
    @user = JTask.get("test.json", 1)
    @user.age.should == 58
  end

  it "adds a paramter to the second, third & fourth objects" do
    JTask.update("test.json", [2, 3, 4], { "send_mail" => false })
    @users = JTask.get("test.json", [2, 3, 4])
    @users.each do |user|
      user.send_mail.should == false
    end
  end

  #it "updates a parameter in the first object" do
    #JTask.update("test.json", { first: 1 }, {"location"=>{"city"=>"Melbourne, Victoria, Australia","postcode"=>3000}})
    #@user = JTask.get("test.json", first: 1)
    #@user.location.city.should == "Melbourne, Victoria, Australia"
  #end

  #it "updates a parameter in the last object" do
    #JTask.update("test.json", { last: 1 }, {"location"=>{"city"=>"Ciudad Juarez, Chihuahua, Mexico","postcode"=>3000}})
    #@user = JTask.get("test.json", last: 1)
    #@user.location.city.should == "Ciudad Juarez, Chihuahua, Mexico"
  #end

  it "adds a parameter to all existing objects" do
    JTask.update("test.json", :all, send_mail: true)
    @users = JTask.get("test.json")
    @users.each do |user|
      user.send_mail.should == true
    end
  end

  it "should return false if the id doesn't exist when updating" do
    @attempt = JTask.update("test.json", 1500, who: "cares")
    @attempt.should == false
  end

  #it "should throw an error if an invalid parameter is used when updating" do
    #expect{JTask.update("test.json", 1, "string?")}.to raise_error(SyntaxError)
  #end

  it "should return false if it attempts to update a file with no objects" do
    require "jtask/destroy"
    JTask.destroy("test.json", :all)
    @attempt = JTask.update("test.json", :all, who: "cares")
    @attempt.should == false
  end

  it "should clear the history using hard coded ruby" do
    # Clear the history
    File.delete("spec/test_files/test.json") if File.exists?("spec/test_files/test.json")
  end
end