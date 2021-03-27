module AvatarHelper
  def avatar(user = current_user)
    content_tag(
      :div,
      "#{user.initials}",
      class: "avatar",
      id: "navbarDropdown",
      data: { toggle: "dropdown" },
      'aria-haspopup': true,
      'aria-expanded': false
    )
  end
end
