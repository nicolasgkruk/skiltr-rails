class CreateJoinTableBetweenSignsAndTags < ActiveRecord::Migration[6.0]
  def change
    create_table :signs_tags, id: false do |t|
      t.references :sign, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
