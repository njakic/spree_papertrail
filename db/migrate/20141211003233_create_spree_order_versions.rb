class CreateSpreeOrderVersions < ActiveRecord::Migration
  def change
    create_table :spree_order_versions do |t|
      t.belongs_to :order, index: true
      t.text :status

      t.timestamps
    end
  end
end
