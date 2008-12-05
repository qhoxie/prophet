$KCODE = 'UTF8'

require 'god'
require 'merb-haml'
require 'merb-helpers'
require 'merb-assets'
require 'merb-action-args'

use_test :rspec
use_template_engine :haml

Merb::BootLoader.before_app_loads do
end
 
Merb::BootLoader.after_app_loads do
end

Merb::Router.prepare do
  match('/').to(:controller => 'prophet', :action =>'index').name(:root)
  match('/no_god').to(:controller => 'prophet', :action => 'no_god').name(:no_god)
  match('/control') do
    with(:controller => 'prophet') do
      match('').to(:action => 'control').name(:control)
      match('/:service/:command').to(:action => 'control')
    end
  end
  
  default_routes
end

Merb::Config.use { |c|
  c[:environment]         = 'production',
  c[:framework]           = {},
  c[:log_level]           = :debug,
  c[:log_stream]          = STDOUT,
  # or use file for logging:
  # c[:log_file]          = Merb.root / "log" / "merb.log",
  c[:use_mutex]           = false,
  c[:session_store]       = 'cookie',
  c[:session_id_key]      = '_prophet_session_id',
  c[:session_secret_key]  = '34f6a3dsdgf9909as90duf078ca1aebe9f4cc3e05b50a',
  c[:exception_details]   = true,
  c[:reload_classes]      = true,
  c[:reload_templates]    = true,
  c[:reload_time]         = 0.5
}

# Connect to God
GOD = DRbObject.new(nil, God::Socket.socket(17165))

# Credentials
USERNAME = "admin"
PASSWORD = "prophet"

# Allowed actions for sending to watches
ACTIONS = %w[ monitor unmonitor start stop restart ]
