class CreateWinners < ActiveRecord::Migration[6.0]
  def change
    create_table :winners do |t|
      t.string :email
      t.string :last_location

      t.timestamps
    end
  end
end
