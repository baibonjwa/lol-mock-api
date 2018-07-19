class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :sex
      t.string :description
      t.string :picture

      t.timestamps
    end
  end
end
