class AddAgentIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :agent_id, :integer
  end
end
