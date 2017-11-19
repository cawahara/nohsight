require "rails_helper"

RSpec.describe FeedbackMailer, type: :mailer do
   describe '#feedback_email' do
      let(:user) { create(:controller_user) }
      let(:mail) { FeedbackMailer.feedback_email(user.email, 'feedback comment') }

      it 'renders the headers' do
         expect(mail.subject).to eq('【Noh Sight】ご意見、お問い合わせ')
         expect(mail.to).to eq(['tsolvalouy@gmail.com'])
         expect(mail.from).to eq([user.email])
      end

      it 'renders the body' do
         expect(mail.parts[0].body).to include('feedback comment')
      end
   end
end
