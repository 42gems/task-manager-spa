class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :token
      t.integer :user_id
      t.datetime :expires_at

      t.timestamps
    end
  end
end
