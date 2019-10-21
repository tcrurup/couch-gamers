class AddUserIdToDevelopers < ActiveRecord::Migration[6.0]
  def change
    add_column :developers, :user_id, :integer
  end
end
