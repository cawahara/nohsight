module UpdateEventAssociations
   extend ActiveSupport::Concern

   def multiple_params(model)
      formed_params = params.require(model).permit!
      array_params = []
      formed_params.each_value do |value|
         array_params << value
      end
      return array_params
   end

   # first required key must be the value for updating class model
   # TODO: RSpecにtypeキーが空の時のテスト記入
   def params_valid?(param_values, foreign_key, required_key, class_model)
      param_values.each do |value|
         next if value['type'] == 'destroy' || value['type'].empty?
         value.each_key do |key|
            next if key == 'id' || key == foreign_key
            return false if value[key].empty?
         end

         if foreign_key.empty?
            return false if ticket_valid?(value) == false
            next
         end

         if class_model.find_by("#{required_key}": value[required_key]).nil?
            new_model_instance = class_model.create("#{required_key}": value[required_key])
            new_model_instance.save
            value[foreign_key] = new_model_instance.id
         else
            value[foreign_key] = class_model.find_by("#{required_key}": value[required_key]).id
         end

      end
      return param_values
   end

   def update_with_params(array_inputs, required_keys, class_model, parent_model)
      array_inputs.each do |inputs|
         params_for_update = {}
         required_keys.each do |key|
            params_for_update[key] = inputs[key]
         end
         case inputs['type']
         when 'update'
            model_instance = class_model.find(inputs['id'])
            model_instance.update_attributes(params_for_update)
         when 'destroy'
            model_instance = class_model.find(inputs['id'])
            model_instance.destroy
         when 'create'
            model_instance = parent_model.build(params_for_update)
            model_instance.save
         end
      end
   end

   private

   def ticket_valid?(ticket_param)
      return false if /[^0-9]+/.match?(ticket_param['price'])
   end
end
