class AddNicknameToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :nickname, :string
  end
end
