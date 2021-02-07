class RemoveNicknameFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :nickname, :string
  end
end
