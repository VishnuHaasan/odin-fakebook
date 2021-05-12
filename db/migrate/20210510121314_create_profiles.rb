class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :dname
      t.text :bio 
      t.integer :age
      t.timestamps
    end
  end
end
