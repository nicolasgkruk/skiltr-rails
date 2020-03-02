class CreateJoinTableBetweenTagsAndProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_tags, id: false do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
