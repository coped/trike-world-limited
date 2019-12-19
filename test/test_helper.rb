ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Add test fixtures
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper

  def log_in_as(user, password: "foobar")
    post login_path, params: { login: { email: user.email,
                                        password: password,
                                        remember: false } }
  end
end
