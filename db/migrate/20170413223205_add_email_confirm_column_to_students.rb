class AddEmailConfirmColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :email_confirmed, :boolean, :default => false
    add_column :students, :confirm_token, :string
    add_column :students, :email_confirm_sent_at, :datetime
  end
end
