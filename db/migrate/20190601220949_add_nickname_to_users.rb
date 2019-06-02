class AddNicknameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address_nickname, :string, default: "home"
  end
end
