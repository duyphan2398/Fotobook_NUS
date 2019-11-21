class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.boolean :sharing_mode

      t.timestamps
    end
  end
end
