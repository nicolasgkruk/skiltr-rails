class CreateExcerptTagsAndSignExcerptsTables < ActiveRecord::Migration[6.0]
  def change
    create_table :excerpt_tags do |t|
      t.belongs_to :user
      t.belongs_to :excerpt
      t.belongs_to :tag

      t.timestamps
    end

    create_table :sign_excerpts do |t|
      t.belongs_to :user
      t.belongs_to :excerpt
      t.belongs_to :sign

      t.timestamps
    end

  end
end
