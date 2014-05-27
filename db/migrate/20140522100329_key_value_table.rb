class KeyValueTable < ActiveRecord::Migration
  def change
    create_table :app_configs, id: false do |t|
      t.string :key
      t.string :value
    end
  end
end
