
const EventPerformer = class EventPerformer {
   constructor(id='', performer_id='', full_name='', mode='create'){
      this.id = id
      this.performer_id = performer_id
      this.full_name = full_name
      this.mode = mode
   }
}

const EventProgram = class EventProgram {
   constructor(id='', program_id='', title='', genre='', event_performers={'0': new EventPerformer()}, mode='create'){
      this.id = id
      this.program_id = program_id
      this.title = title
      this.genre = genre
      this.event_performers = event_performers
      this.mode = mode
   }
}

const Ticket = class Ticket {
   constructor(id='', grade='', price='', mode='create'){
      this.id = id
      this.grade = grade
      this.price = price
      this.mode = mode
   }
}

module.exports = {EventPerformer, EventProgram, Ticket}
