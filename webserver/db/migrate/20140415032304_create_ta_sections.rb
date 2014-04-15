class CreateTaSections < ActiveRecord::Migration
  def change
    create_table :ta_sections, :id => false do |t|
      t.belongs_to :ta
      t.belongs_to :section
    end

    add_index :ta_sections, [:ta_id, :section_id], :unique => true
  end
end
