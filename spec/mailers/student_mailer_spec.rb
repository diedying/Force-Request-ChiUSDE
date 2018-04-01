# spec/mailers/student_mailer_spec.rb
# example for how to write this test can be found at
# https://www.lucascaton.com.br/2010/10/25/how-to-test-mailers-in-rails-with-rspec/
require 'spec_helper'

RSpec.describe StudentMailer, type: :mailer do
  describe 'registration_confirmation' do
    before :each do
      @student = Student.new( name: 'Bernard Lowe', email: 'blowe@westworld.com', password: 'IAmArnorld', uin: 12345678)
      @student.save
    end

    let(:mail) { described_class.registration_confirmation(@student).deliver_now }

    it 'renders the subject' do
      StudentMailer.registration_confirmation(@student)
      expect(mail.subject).to eq('Registration Confirmation')
      expect(mail.to).to eq(['blowe@westworld.com'])
    end

    after :each do
      @student.destroy
    end
  end

  describe 'confirm_force_request' do
    before :each do
      @fake_student_request = FactoryGirl.create(:student_request)
      @student = Student.new( name: 'Bernard Lowe', email: 'blowe@westworld.com', password: 'IAmArnorld', uin: 12345678)
      @student.save
    end

    let(:mail) { described_class.confirm_force_request(@student, @fake_student_request).deliver_now }

    it 'renders the subject' do
      StudentMailer.confirm_force_request(@student, @fake_student_request)
      expect(mail.subject).to eq('Request Confirmation')
      expect(mail.to).to eq(['blowe@westworld.com'])
    end

    after :each do
      @student.destroy
    end
  end

  describe 'reset password' do
    before :each do
      @student = Student.new( name: 'Bernard Lowe', email: 'blowe@westworld.com', password: 'IAmArnorld', uin: 12345678)
      @student.save
    end

    let(:mail) { described_class.reset_password(@student).deliver_now }

    it 'renders the subject' do
      StudentMailer.reset_password(@student)
      expect(mail.subject).to eq('Reset Your Password')
      expect(mail.to).to eq(['blowe@westworld.com'])
    end

    after :each do
      @student.destroy
    end
  end
end
