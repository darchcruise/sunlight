class CreatePoliticiansTable < ActiveRecord::Migration
  def up
    create_table :politicians do |t|
      t.string :first
      t.string :last
      t.string :party
      t.string :phone
      t.string :state
      t.string :twitter_id

      t.timestamps
    end
  end

  def down
    drop_table :politicians
  end
end
