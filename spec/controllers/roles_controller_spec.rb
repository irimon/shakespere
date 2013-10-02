require 'spec_helper'

describe "Check controller" do

  
  describe "creating a table" do

    it "should create table" do
	 before(:all) do 
		click_button "Create Table" 
    end

	it "check line count" do
		line_count = 0
		for role in Role.all
			line_count = line_count + role.number_of_lines
		end
		path = Rails.public_path + "/julius_caesar.xml"
		doc = Nokogiri::XML(open(path))
		expected_line_count =  doc.xpath('LINE').count
		line_count.should be(expected_line_count)
	end
   
   
  end

  describe "deleting a table with Ajax" do

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.to change(Role, :count).to(0)
    end

  end
end