class ChangeColumEmailUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :email, :string
  end
end
