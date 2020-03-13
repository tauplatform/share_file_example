require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ShareController < Rho::RhoController
  include BrowserHelper

  # GET /Share
  def index
    render :back => '/app'
  end

  def share_file
      puts "$$$ share_file START"

      uri_prefix = "content://"

      ## this is application package !
      uri_id = "com.tau.sharefile"
      uri_path_prefix = "/rhodata/apps"

      ## this is path from User folders
      ## we recommend store files in User folder
      ## User folder = Rho::RhoApplication::userFolder
      ## in this case we do not place file into User folder but direct link file from "app" folder. On Android User folder is the same with root of application's files where located "app" folder
      uri_file_path = "/app/Share/from_ruby.png"

      uri = uri_prefix + uri_id + uri_path_prefix + uri_file_path

      intentParams = {
        :action => "android.intent.action.SEND",
        :data => {"android.intent.extra.STREAM" => uri},
        :intentType => Rho::Intent::START_ACTIVITY,
        :mimeType => "image/*",
        :uri => "android.intent.category.DEFAULT"
        }
      puts "$$$ Intent parameters prepared"

      Rho::Intent.send(intentParams)

      puts "$$$ share_file FINISH"
  end

end
