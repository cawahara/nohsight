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

   def create_params_instance(params, model, foreign_key, required_key, refer_model)
      return true if params['mode'] == 'destroy' || params['mode'].empty?
      params_for_instance = {}
      model.required_columns.each do |required_column|
         params[required_column] = create_foreign_key(params, required_key, refer_model) if required_column == foreign_key
         params_for_instance[required_column] = params[required_column]
      end
      return model.new(params_for_instance).valid? ? params_for_instance : false
   end

   def execute_crud_actions(params, params_for_instance, model)
      case params['mode']
      when 'create'
         model.create!(params_for_instance)
      when 'update'
         model.find(params[:id]).update_attributes(params_for_instance)
      when 'destroy'
         model.find(params[:id]).destroy!
      end
   end

   def update_bundled_records(params, model, foreign_key, required_key, refer_model)
      new_params = []
      params.each do |param|
         params_for_instance = create_params_instance(param, model, foreign_key, required_key, refer_model)
         return false if params_for_instance == false
         new_params << params_for_instance
      end
      params.each_with_index do |_val, idx|
         execute_crud_actions(params[idx], new_params[idx], model)
      end
      return true
   end

   private

   def create_foreign_key(param, required_key, model)
      instance = model.find_or_create_by("#{required_key}": param[required_key])
      return instance.id
   end
end
