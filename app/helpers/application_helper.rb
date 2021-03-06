module ApplicationHelper

  def logo
    image_tag("rails.png", :alt=> "sample app", :class=>"round")
  end
  
  #return title on a per-page basis
  def title
    base_title = "Ruby on rails tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end


