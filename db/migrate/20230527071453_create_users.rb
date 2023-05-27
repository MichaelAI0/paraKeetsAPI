class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :password_digest
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :avatar

      t.timestamps
    end
  end
end
