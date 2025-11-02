class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.string :name
      t.references :todo, null: false, foreign_key: true
      t.boolean :done

      t.timestamps
    end
  end
end
