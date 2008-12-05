class Prophet < Merb::Controller

	before :authenticate
	before :ping, :exclude => [:no_god]

  ##
  # Shows status and resource usage of all watches	
  ##
  def index
    @watches = GOD.watches
		display @watches
  end
  
  ##
  # Displays simple error is god connection is lost	
  ##
  def no_god
    render "<h2 class='error'>Error: Could not connect to a God instance!</h2><h3>Perhaps the daemon died?</h3>"
  end

  ##
  # Handles control commands for services	
  ##
  def control(command, service)
    return redirect(url(:root)) unless ACTIONS.include? command.to_s
    GOD.control service, command.to_s
    redirect url(:root)
  end
  
  protected

  ##
  # Basic authentication for interface
  ##
	def authenticate
	  basic_authentication("Prophet") do |username, password|
	    (password == PASSWORD) and (username == USERNAME)
	  end
	end

  ##
  # Ensures connection to god before interacting with the daemon
  ##
	def ping
	  GOD.ping
	rescue DRb::DRbConnError
		throw :halt, redirect(url(:no_god))
	end
	
end
