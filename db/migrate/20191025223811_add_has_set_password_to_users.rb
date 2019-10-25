class AddHasSetPasswordToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :set_pw, :boolean, :default => true
  end
end
