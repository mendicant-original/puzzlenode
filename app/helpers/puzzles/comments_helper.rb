module Puzzles::CommentsHelper
  
  def toggle_source_url(user, icon="icons/edit.png")
    return if user != current_user
    
    link_to_function image_tag(icon), 
      %{$('#share-source').slideToggle()},
      :class => "edit"
  end
end
