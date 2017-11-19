require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe '#confirmation_email' do
     let(:user) { create(:controller_user, confirmed: false, confirmed_at: nil) }
     let(:mail) { UserMailer.confirmation_email(user) }

     it 'renders the headers' do
        expect(mail.subject).to eq('【Noh Sight】 本登録のご案内')
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(['info@nohsight.com'])
     end

     it 'renders the body' do
        expect(mail.parts[0].body).to include(confirmation_url(email: user.email, token: user.confirmation_token))
     end
  end

  describe '#password_reset_email' do
     let(:user) { create(:controller_user) }
     let(:mail) { UserMailer.password_reset_email(user) }

     before(:each) do
        user.create_password_reset_token
     end

     it 'renders the headers' do
        expect(mail.subject).to eq('【Noh Sight】 パスワード再設定のご案内')
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(['info@nohsight.com'])
     end

     it 'renders the body' do
        expect(mail.parts[0].body).to include(edit_password_reset_url(email: user.email, token: user.password_reset_token))
     end
  end
end
