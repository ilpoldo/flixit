require 'spec_helper'


context "Create a Job" do
  before(:each) do
    @job = Flixit::Job.new(:recipe_id => 1,
                           :api_key => 'this_is_an_api_key',
                           :file_locations => { :input =>      {:url => 'http://flixcloud.com/somefile.mp4'},
                                                :output =>     {:url => 's3://flixcloud/somefile.flv'},
                                                :thumbnails => {:url => "s3://flixcloud/somefile/",:prefix => 'thumbnail'}})
    Fredo.post "https://www.flixcloud.com/jobs" do
      [201, {}, %{<?xml version="1.0" encoding="UTF-8"?><job><id type="integer">3254</id><initialized-job-at type="datetime">2009-02-11T01:23:54Z</initialized-job-at></job>}]
    end

  end
  
  it "formats a message for flixcloud" do
    @job.to_xml.should eql(%{<?xml version=\"1.0\" encoding=\"UTF-8\"?><api-request><api-key>this_is_an_api_key</api-key><recipe-id>1</recipe-id><file-locations><input><url>http://flixcloud.com/somefile.mp4</url></input><output><url>s3://flixcloud/somefile.flv</url></output><thumbnails><url>s3://flixcloud/somefile/</url><prefix>thumb_</prefix></thumbnails></file-locations></api-request>})
  end
  
  it "posts a message to flixcloud" do    
    @job.save.should be_true
  end
  
  it "has a passthrough option" do    
    job = Flixit::Job.new(:recipe_id => 1,
                           :api_key => 'this_is_an_api_key',
                           :pass_through => YAML.dump({:key => 'value'}),
                           :file_locations => { :input =>      {:url => 's3://mybucket/somefile.mp4'},
                                                :output =>     {:url => 's3://mybucket/somefile.flv'},
                                                :thumbnails => {:url => "s3://mybucket/somefile/"}})
   job.save

   request = Crack::XML.parse Fredo.books.last[:body]
   YAML.load(request['api_request']['pass_through']).should eql({:key => 'value'})
  end
  
  it "should follow redirects" do
    # Setup redirection to http
    Fredo.forget
    Fredo.post "https://www.flixcloud.com/jobs" do
      if env['rack.url_scheme'] == 'https'
        [303, {'LOCATION' => "http://www.flixcloud.com/jobs"}, 'This item has moved permanently']
      else
        [201, {}, %{<?xml version="1.0" encoding="UTF-8"?><job><id type="integer">3254</id><initialized-job-at type="datetime">2009-02-11T01:23:54Z</initialized-job-at></job>}]
      end
    end
    
    @job.should be_valid
    @job.save.should be_true
  end
end