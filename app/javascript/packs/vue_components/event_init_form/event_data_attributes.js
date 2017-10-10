const event_performer = { id:            '',
                          performer_id:  '',
                          full_name:     '',
                          mode:          'create' }
const event_program = { id:               '',
                        program_id:       '',
                        title:            '',
                        genre:            '',
                        event_performers: { '0': event_performer },
                        mode:             'create' }
const ticket = { id:    '',
                 grade: '',
                 price: '',
                 mode:  'create' }

const DataAttributes = {
   event_performer: event_performer,
   event_program: event_program,
   ticket: ticket
}

module.exports = {DataAttributes}
