module RailsAdminAasm
  class Configuration
    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def options
      @options ||= {
          states: {
            published: 'label-success',
            sent: 'label-success',
            done: 'label-success',
            cancelled: 'label-important',
            deleted: 'label-important',
            trashed: 'label-important',
            draft: 'label-important',
          },
          events: {
            publish: 'btn-success',
            confirm: 'btn-success',
            send: 'btn-success',
            done: 'btn-success',
            cancel: 'btn-danger',
            delete: 'btn-danger',
            trash: 'btn-danger',
          },
          disable: [],
          wrapper_style: nil,
          current_state_tag: nil,
          current_state_style: nil
      }.merge(config)
      @options
    end

    def state(name)
      return '' if name.nil?
      options[:states][name.to_sym] || 'label-default'
    end

    def event(name)
      return '' if name.nil?
      options[:events][name.to_sym] || 'btn-default'
    end

    def disabled?(name)
      return '' if name.nil?
      options[:disable].include? name.to_sym
    end

    def authorize?
      options[:authorize]
    end

    def wrapper_style
      options[:wrapper_style] || 'style="white-space: normal;"'
    end

    def current_state_tag
      options[:current_state_tag] || 'button'
    end

    def current_state_style
      options[:current_state_style] || 'disabled="disabled"'
    end

    protected

    def config
      begin
        opt = ::RailsAdmin::Config.model(@abstract_model.model).state
        if opt.nil?
          {}
        else
          opt
        end
      rescue
        {}
      end
    end
  end
end
