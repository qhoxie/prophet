require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe Prophet do
  
  describe '/' do
    it "should redirect to 'no god' page with no daemon running" do
      response = dispatch_with_basic_authentication_to(Prophet, :index, USERNAME, PASSWORD)
      response.should redirect_to '/no_god'
    end
  end

end
