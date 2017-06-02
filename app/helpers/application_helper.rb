module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'Password1234 -- OpenHack 2017'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
