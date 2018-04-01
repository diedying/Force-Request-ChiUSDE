# spec/mailers/student_mailer_spec.rb
# example for how to write this test can be found at
# https://www.lucascaton.com.br/2010/10/25/how-to-test-mailers-in-rails-with-rspec/
require 'spec_helper'

RSpec.describe StudentMailer, type: :mailer do
  describe 'registration_confirmation' do
    #let(:student) {mock_model Student, name: 'Bernard Lowe', email: 'blowe@westworld.com', password: 'IAmArnorld', uin: 12345678}

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

    # it 'should send an email' do
    #   ActionMailer::Base.deliveries.count.should == 1
    # end
    #
    # after(:each) do
    #   ActionMailer::Base.deliveries.clear
    # end


  end
end
