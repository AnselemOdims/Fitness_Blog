class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|

      t.timestamps
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
    end
  end
end
