class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world!0"
  end

end
