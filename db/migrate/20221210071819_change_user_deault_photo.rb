class ChangeUserDeaultPhoto < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:users, :photo, from: nil, to: 'photo.png')
  end
end
