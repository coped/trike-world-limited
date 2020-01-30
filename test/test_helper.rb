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

# Remove Active Storage files stored during integration tests

module RemoveUploadedFiles
  def after_teardown
    super
    remove_uploaded_files
  end

  private

  def remove_uploaded_files
    FileUtils.rm_rf(Rails.root.join('tmp', 'storage'))
  end
end

module ActionDispatch
  class IntegrationTest
    prepend RemoveUploadedFiles
  end
end
