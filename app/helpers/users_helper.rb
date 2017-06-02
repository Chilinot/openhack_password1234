module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    id = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{id}?s=#{size}"
    image_tag url, alt: user.name, class: "gravatar"
  end

  # Confirms an admin user.
  # Redirects to root otherwise.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
