class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :receipt
      t.references :user, index: true
      t.text :ip_address
      t.text :filename
      t.text :content_type
      t.binary :file_contents

      t.timestamps
    end
  end
end
