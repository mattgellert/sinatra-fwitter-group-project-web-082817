require './config/environment'


use Rack::MethodOverride
use TweetController
use UserController
run ApplicationController
