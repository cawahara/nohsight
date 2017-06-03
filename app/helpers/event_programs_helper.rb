module EventProgramsHelper

   def ev_program_for_vue_attr(ev_program)
      ev_performers = []
      ev_program.event_performers.each do |ev_performer|
         ev_performers << ev_performer.performer
      end
      program = ev_program.program
      return {
         ev_program: ev_program,
         ev_performers: ev_performers,
         program:       program
      }
   end
end
