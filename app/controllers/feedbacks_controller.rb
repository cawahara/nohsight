# frozen_string_literal: true

class FeedbacksController < ApplicationController

   def new
      @email = ''
      @content = ''
   end

   def create
      @email = params[:feedback][:email]
      @content = params[:feedback][:content]
      if @email.match?(User::VALID_EMAIL_REGEX) && !@content.empty?
         FeedbackMailer.feedback_email(@email, @content).deliver
         flash[:success] = 'ご意見メールを送信しました！'
         redirect_to(root_url)
      else
         if !@email.match?(User::VALID_EMAIL_REGEX)
            flash.now[:danger] = 'メールアドレスが正しく入力されておりません'
         else
            flash.now[:danger] = 'ご意見を入力してください'
         end
         render 'feedbacks/new'
      end
   end

end
