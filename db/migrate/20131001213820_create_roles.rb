class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :number_of_lines
      t.integer :longest_speach
      t.integer :number_of_scenes
      t.float :scenes_percent

      t.timestamps
    end
  end
end
