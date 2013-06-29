module ApplicationHelper

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
