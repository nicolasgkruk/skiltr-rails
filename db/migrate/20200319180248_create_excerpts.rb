class CreateExcerpts < ActiveRecord::Migration[6.0]
  def change
    create_table :excerpts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :source, null: false, foreign_key: true
      t.text :content
      t.numeric :location_reference

      t.timestamps
    end
  end
end
