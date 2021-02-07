module SpecialsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm' || action_name == 'create'
      confirm_specials_path
    elsif action_name == 'edit'
      special_path
    end
  end

  # def confirm_new_or_edit
  #   # 優待記事新規投稿とアップデートに分岐したいが…
  #   unless @special.id?
  #     specials_path
  #   else
  #     special_path
  #   end
  # end

  def confirm_form_method
    @special.id ? 'patch' : 'post'
  end
end
