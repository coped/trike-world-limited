class ChangePostsTitleAndBodyColumnTypesToText < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      direction.up do
        change_column :posts, :title, :text
        change_column :posts, :body, :text
      end
      direction.down do
        change_column :posts, :title, :string
        change_column :posts, :body, :string
      end
    end
  end
end
