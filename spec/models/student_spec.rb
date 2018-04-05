require 'spec_helper'
require 'rails_helper'

describe Student do
  before :each do
    @student = FactoryGirl.create(:student)
  end

  it "should save email on activation" do
    @student.should_receive(:save!)

    @student.email_activate

    expect(@student.email_confirmed).to be true
    expect(@student.confirm_token).to be_nil
  end

  it "should activate the email" do
    @student.should_receive(:save!)

    @student.email_activate

    expect(@student.reset_password_confirm_token).to be_nil
  end

  it "should reset the password" do
    @student.should_receive(:save!)

    @student.password_reset_done

    expect(@student.reset_password_confirm_token).to be_nil
  end

    it "should create a password confirmation token if one does not exist" do
      #@student.reset_password_confirm_token = ""
       SecureRandom.should_receive(:urlsafe_base64).once.and_return("A SECURE TOKEN")
       @student.should_receive(:save!)

      @student.reset_password_confirmation_token()

       expect(  @student.reset_password_confirm_token).to eq("A SECURE TOKEN")
    end

    context("Password Reset") do
      it "should return false if reset less than an hour ago" do
        @student.reset_sent_at = 1.minute.ago

        password_reset_expired = @student.password_reset_expired?

        expect(password_reset_expired).to be false
      end

      it "should return true if reset more than an hour ago" do
        @student.reset_sent_at = 1.day.ago

        password_reset_expired = @student.password_reset_expired?

        expect(password_reset_expired).to be true
      end
    end

end
