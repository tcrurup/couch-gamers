class CreateUserDevelopers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_developers do |t|
      t.integer :user_id
      t.integer :developer_id
    end
  end
end
