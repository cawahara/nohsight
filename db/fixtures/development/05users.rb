# frozen_string_literal: true

names = ['good example', 'gen uchida', 'yasu takagi', 'ai ouchi', 'fumihisa taguchi',
         'goro yoshida', 'johny honda', 'eiji ito', 'junta tanaka', 'maruko okamoto',
         'shinichiro higashihara', 'sota otuska', 'shun kaito', 'junta nakata', 'hidekazu mukai']

i = 1
names.each do |name|
   User.seed do |s|
      s.id              = i
      s.name            = name
      s.email           = "#{name.split(/\s/)[1]}@gmail.com"
      s.password_digest = User.digest('password')
   end
   i += 1
end
