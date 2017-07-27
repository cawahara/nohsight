# frozen_string_literal: true

module UpdateEventAssociations
   extend ActiveSupport::Concern

   def get_params(model)
      formed_params = params.require(model).permit!
      array_params = []
      formed_params.each_value do |value|
         array_params << value
      end
      return array_params
   end

   # first required key must be the value for updating class model
   # TODO: RSpecにtypeキーが空の時のテスト記入
   def params_valid?(params, foreign_key, required_key, model)
      params.each do |param|
         next if param['type'] == 'destroy' || param['type'].empty?
         return false if keys_valid?(param, foreign_key) == false

         if foreign_key.empty?
            return false if ticket_valid?(param) == false
            next
         end
         param[foreign_key] = create_foreign_key(param, required_key, model)
      end
      return params
   end

   def update_records(array_inputs, required_keys, model)
      array_inputs.each do |inputs|
         params_for_update = {}
         required_keys.each do |key|
            params_for_update[key] = inputs[key]
         end

         query_for_record(model, inputs, params_for_update)
      end
   end

   private

   def keys_valid?(param, foreign_key)
      param.each_key do |key|
         next if key == 'id' || key == foreign_key
         return false if param[key].empty?
      end
      return true
   end

   def ticket_valid?(ticket_param)
      return false if /[^0-9]+/.match?(ticket_param['price'])
   end

   def create_foreign_key(param, required_key, model)
      instance = model.find_by("#{required_key}": param[required_key])
      if instance.nil?
         instance = model.create("#{required_key}": param[required_key])
         instance.save
      end
      return instance.id
   end

   def query_for_record(model, inputs, params)
      case inputs['type']
      when 'update'
         model.find(inputs['id']).update_attributes(params)
      when 'destroy'
         model.find(inputs['id']).destroy
      when 'create'
         model.create(params)
      end
   end
end
