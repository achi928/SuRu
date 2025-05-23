class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|

      t.integer :member_id, null: false
      t.integer :group_id, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
