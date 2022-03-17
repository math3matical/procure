require 'rest-client'
require 'fileutils'
include RestClient
class ColorChange < ApplicationService
  attr_reader :message
  
  def initialize(file)
    @css_file = file
  end

  def call
    FileUtils.cp("/root/procure/app/assets/stylesheets/backup-colors/#{@css_file}", "/root/procure/app/assets/stylesheets/colorscheme.css")
  end
end
