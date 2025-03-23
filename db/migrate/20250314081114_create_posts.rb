class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :member_id, null: false
      t.integer :group_id, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
