class AddDeveloperIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :developer_id, :integer
  end
end
