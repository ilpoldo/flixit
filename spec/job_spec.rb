require 'spec_helper'


context "Create a Job" do
  before(:each) do
    @job = Flixit::Job.new(:recipe_id => 1,
                           :api_key => 'this_is_an_api_key',
                           :file_locations => { :input =>      {:url => 'http://flixcloud.com/somefile.mp4'},
                                                :output =>     {:url => 's3://flixcloud/somefile.flv'},
                                                :thumbnails => {:url => "s3://flixcloud/somefile/",:prefix => 'thumbnail'}})
    Fredo.post "https://flixcloud.com/jobs" do
      %{<?xml version="1.0" encoding="UTF-8"?><job><id type="integer">3254</id><initialized-job-at type="datetime">2009-02-11T01:23:54Z</initialized-job-at></job>}
    end

  end
  
  it "formats a message for flixcloud" do
    @job.to_xml.should eql(%{<?xml version=\"1.0\" encoding=\"UTF-8\"?><api-request><api-key>this_is_an_api_key</api-key><recipe-id>1</recipe-id><file-locations><input><url>http://flixcloud.com/somefile.mp4</url></input><output><url>s3://flixcloud/somefile.flv</url></output><thumbnails><url>s3://flixcloud/somefile/</url><prefix>thumb_</prefix></thumbnails></file-locations></api-request>})
  end
  
  it "posts a message to flixcloud" do    
    @job.save
  end
  
end