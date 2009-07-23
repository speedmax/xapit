require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Xapit::CouchRestModelAdapter do
  it "should be used for ActiveRecord::Base subclasses" do
    pending
    Xapit::CouchRestModelAdapter.should_not be_for_class(Object)
    klass = Object.new
    stub(klass).ancestors { ["CouchRest::Base"] }
    Xapit::CouchRestModelAdapter.should be_for_class(klass)
  end
  
  it "should pass find_single to find method to target" do
    pending
    target = Object.new
    mock(target).get(1) { :record }
    adapter = Xapit::CouchRestModelAdapter.new(target)
    adapter.find_single(1).should == :record
  end
  
  it "should pass find_multiple to find method to target" do
    pending
    target = Object.new
    mock(target).get(1) { :record }
    mock(target).get(2) { :record }
    adapter = Xapit::CouchRestModelAdapter.new(target)
    adapter.find_multiple([1, 2]).should == :record
  end
  
  it "should pass find_each to target" do
    pending
    target = Object.new
    mock(target).find_each(:args) { 5 }
    adapter = Xapit::CouchRestModelAdapter.new(target)
    adapter.find_each(:args).should == 5
  end
end