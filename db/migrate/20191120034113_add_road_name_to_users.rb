class AddRoadNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :road_name, :string
  end
end
