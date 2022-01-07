class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_line1
      t.string :street_line2
      t.string :zipcode
      t.string :email
      t.integer :salary_cents

      t.timestamps
    end
  end
end
