class RemoveDeviseFieldsAndAddCustomAuthToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :encrypted_password, :reset_password_token, :reset_password_sent_at,
               :remember_created_at, :sign_in_count, :current_sign_in_at,
               :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
      t.string :password_hash
      t.string :password_salt
    end
  end
end
