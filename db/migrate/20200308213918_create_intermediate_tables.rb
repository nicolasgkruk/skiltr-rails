class CreateIntermediateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :sign_tags do |t|
      t.belongs_to :user
      t.belongs_to :sign
      t.belongs_to :tag

      t.timestamps
    end

  end
end