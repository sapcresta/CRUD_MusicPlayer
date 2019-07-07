
require_relative "../lib/my_db"
require_relative "spec_helper.rb"
RSpec.describe DBtransaction do 
    before(:all) do
        @con=Mysql2::Client.new(:host => "localhost", :username => "sapana", :password => "S@p@n@123", :database => "crud_database")
    end
    after(:all) do 
        @con.close
    end

    db=DBtransaction.new
    it "create a class DBtransaction" do
   
    expect(db).to be_kind_of(DBtransaction)
end

it "checks whether music_list table exits or not" do
    result=db.create_table
    expect(result).to eql("tablecreated")
end


    
end