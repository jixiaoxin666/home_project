class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :user_name
      t.string :user_email
      t.text :user_comment

      t.timestamps
    end
  end
end
