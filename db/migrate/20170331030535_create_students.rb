class CreateStudents < ActiveRecord::Migration
  def up
    create_table 'students' do |t|
      t.string 'uin'
      t.string 'password'
      t.string 'name'
      t.string 'email'
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
  
  def down
    drop_table 'students'
  end

end
