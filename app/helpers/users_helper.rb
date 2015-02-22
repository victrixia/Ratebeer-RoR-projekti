module UsersHelper

  def freeze_label_name(user)
    return "freeze" if user.active
    "unfreeze"
  end
end
