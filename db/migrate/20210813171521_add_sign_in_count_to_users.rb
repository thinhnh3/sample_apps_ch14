class AddSignInCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sign_in_count, :integer, default: 0
  end
end
