class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :password_reset, :reset_digest
  end
end
