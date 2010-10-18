# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :build_footer, :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def action_allowed
    true
  end

  def build_footer
    @footer = {}
    @footer[:archives] = Post.all.group_by{ |p| "#{p.created_at.year}/#{p.created_at.month}" }
    @footer[:recent] = Post.all.last(5).reverse
    @footer[:tags] = Post.tag_counts_on(:tags)
    @footer[:links] = {"The Knot" => "http://www.theknot.com/",
                       "STL Weddings" => "http://www.stlouisweddings.com/",
                       "Yelp" => "http://www.yelp.com/stlouis",
                       "STL Weddings" => "http://www.stlouisweddings.com/",
                       "STL Weddings" => "http://www.stlouisweddings.com/",

            }
  end
end
