class AddUserToAnnotations < ActiveRecord::Migration[4.2]
  def change
    add_reference :annotations, :user, index: true, foreign_key: true
  end
end
