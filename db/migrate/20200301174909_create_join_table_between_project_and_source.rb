class CreateJoinTableBetweenProjectAndSource < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_sources, id: false do |t|
      t.references :project, index: true, foreign_key: true
      t.references :source, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
