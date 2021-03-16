module AvatarHelper
  def avatar(user = current_user)
    content_tag(
      :div,
      "#{user.first_name[0]}#{user.last_name[0]}",
      class: "avatar",
      id: "navbarDropdown",
      data: { toggle: "dropdown" },
      'aria-haspopup': true,
      'aria-expanded': false
    )
  end
end
