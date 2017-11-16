# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
   default from: 'info@nohsight.com'
   layout 'mailer'
end
