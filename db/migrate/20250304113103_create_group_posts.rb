class CreateGroupPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :group_posts do |t|

      t.integer :member_id, null: false
      t.integer :group_id, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
