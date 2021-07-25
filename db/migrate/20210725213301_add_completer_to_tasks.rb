class AddCompleterToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :completer, foreign_key: {to_table: :users}
  end
end
