class AddResetPasswordConfirmToStudents < ActiveRecord::Migration
  def change
    add_column :students, :reset_password_confirm_token, :string
  end
end
