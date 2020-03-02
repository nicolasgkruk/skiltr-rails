class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.string :title, index: true
      t.string :author, index: true
      t.string :url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
